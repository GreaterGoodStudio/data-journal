class SessionsController < ApplicationController
  before_action :find_session, except: [:upload]
  before_action :show_submenu, only: [:index]
  skip_before_action :authenticate_user!, only: [:upload]

  def index
    @show_all = params[:show] == "all"
    @sessions = @project.sessions.order(created_at: :desc).page(params[:page])
    @sessions = @sessions.for_member(current_user) unless @show_all
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
    @photos_uploader.success_action_redirect = upload_asset_to_session_url(@session.id, :photo)
  end

  def upload
    @session = Session.friendly.find(params[:id])
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
