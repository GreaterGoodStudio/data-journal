class SessionsController < ApplicationController
  include Sortable

  before_action :find_session
  before_action :show_submenu, only: [:index]

  def index
    @show_all = params[:show] == "all"
    @sessions = @project.sessions.for_member(current_user).order("#{sort_column} #{sort_direction}").page(params[:page])
  end

  def create
    @session = @project.sessions.new(session_params)
    @session.member = current_user
    authorize @session
    if @session.save
      redirect_to @session, notice: "Session created."
    else
      respond_to do |format|
        format.html { render :new, error: @session.errors.full_messages.to_sentence }
        format.js { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    if @session.update_attributes(session_params)
      redirect_to @session, notice: "Session updated."
    else
      flash.now[:error] = @session.errors.full_messages.to_sentence
      render :edit
    end
  end

  def show
    @data_points = @session.data_points
    @photos = @session.photos
    @consent_forms = @session.consent_forms

    @photos_uploader = Photo.new.image
    @photos_uploader.success_action_status = "201"
  end

  def upload
    @photo = @session.photos.new(key: params[:key])

    head @photo.save_and_process ? :ok : :bad_request
  end

  private

    def find_session
      return unless params[:id]

      @session = Session.friendly.find(params[:id])
      authorize @session
    end

    def session_params
      params.require(:session).permit(:name, :date)
    end
end
