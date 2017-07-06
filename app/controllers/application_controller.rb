class ApplicationController < ActionController::Base
  include Pundit

  EXTRA_USER_FIELDS = %w(name avatar avatar_cache eula)

  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  before_action :find_project
  before_action :find_session

  def render(*args)
    decorate_all
    super(*args)
  end

  private

    def pundit_user
      UserContext.new(current_user, current_project)
    end

    def find_project
      return unless params[:project_id].present?

      @project = Project.friendly.find(params[:project_id])
    end

    def find_session
      return unless params[:session_id].present?

      @session = Session.friendly.find(params[:session_id])
    end

    def current_project
      @project || @session.try(:project) || @data_point.try(:project) || @photo.try(:project) || @consent_form.try(:project)
    end

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform that action."
      redirect_to(request.referrer || root_path)
    end

    def decorate_all
      %w(project projects session sessions members data_point data_points).each do |var|
        decorated = instance_variable_get("@#{var}").try(:decorate)
        instance_variable_set("@#{var}", decorated) if decorated
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: EXTRA_USER_FIELDS)
      devise_parameter_sanitizer.permit(:account_update,    keys: EXTRA_USER_FIELDS)
    end

    def show_submenu
      @submenu = true
    end
end
