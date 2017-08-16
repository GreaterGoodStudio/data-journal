class DataPointsController < ApplicationController
  before_action :find_data_point
  before_action :find_related_points, only: [:new, :show, :edit, :update]

  def new
    @data_point = @session.data_points.new
    authorize @session, :edit?

    if params[:photo]
      @photo = Photo.find(params[:photo])
      @data_point.croppable_photo_id = @photo.id
    end
  end

  def create
    @data_point = @session.data_points.new(data_point_params)
    authorize @data_point

    if @data_point.save
      redirect_to new_session_data_point_path(@session), notice: "Data point created."
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

  def show
    respond_to do |format|
      format.html
      format.pdf do
        @data_points = [@data_point]
        render pdf: "data_point_#{@data_point.id}"
      end
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
    set_bookmark(true)
  end

  def unbookmark
    set_bookmark(false)
  end

  private

    def find_data_point
      return unless params[:id].present?

      @data_point = DataPoint.find params[:id]
      @project ||= @data_point.project

      authorize @data_point
    end

    def find_related_points
      @session ||= @data_point.session
      @related_points = @session.data_points.recent(6, params[:id]).decorate
    end

    def data_point_params
      params.require(:data_point).permit(:croppable_photo_id, :crop_x, :crop_y, :crop_w, :crop_h, :observation, :meaning)
    end

    def bookmark_attr
      policy(@data_point.project).moderator? ? :bookmark_moderator : :bookmark_member
    end

    def set_bookmark(val)
      if @data_point.update_attribute bookmark_attr, val
        respond_to do |format|
          format.html { redirect_to :back, notice: "Bookmark updated" }
          format.js
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, error: "Problem updating bookmark" }
          format.js { render "bookmark_error" }
        end
      end
    end
end
