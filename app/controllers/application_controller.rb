class ApplicationController < ActionController::Base
  include Pundit

  EXTRA_USER_FIELDS = %w(name avatar avatar_cache)

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :find_project
  before_action :find_session

  def render(*args)
    decorate_all
    super(*args)
  end

  private

    def find_project
      return unless params[:project_id]
      @project = Project.friendly.find(params[:project_id])
    end

    def find_session
      return unless params[:session_id]
      @session = Session.friendly.find(params[:session_id])
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
