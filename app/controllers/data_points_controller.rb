class DataPointsController < ApplicationController
  before_action :find_data_point
  before_action :find_related_points, only: [:new, :show, :edit]

  def new
    @data_point = @session.data_points.new
  end

  def create
    @data_point = @session.data_points.new(data_point_params)
    authorize @data_point

    if @data_point.save
      redirect_to @data_point, notice: "Data point created."
    else
      respond_to do |format|
        format.html { render :new, error: @data_point.errors.full_messages.to_sentence }
        format.js { render json: @data_point.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @data_point.update_attributes(data_point_params)
      redirect_to @data_point, notice: "Data Point updated."
    else
      flash.now[:error] = @data_point.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    session = @data_point.session
    if @data_point.destroy
      flash[:notice] = "Data point was deleted."
    else
      flash[:error] = "Problem deleting data point."
    end

    redirect_to session
  end

  def bookmark
    @data_point.update_attribute bookmark_attr, true
    redirect_to :back
  end

  def unbookmark
    @data_point.update_attribute bookmark_attr, false
    redirect_to :back
  end

  private
    def find_data_point
      return unless params[:id]

      @data_point = DataPoint.find params[:id]
      authorize @data_point
    end

    def find_related_points
      session = @session || @data_point.session
      @related_points = session.data_points.decorate
    end

    def data_point_params
      params.require(:data_point).permit(:photo_id, :observation, :meaning)
    end

    def bookmark_attr
      policy(@data_point.project).moderator? ? :bookmark_moderator : :bookmark_member
    end
end