class Users::InvitationsController < Devise::InvitationsController
  before_action :set_eula_url

  private

    def after_accept_path_for(_resource)
      flash.clear
      edit_user_avatar_path(invited: true)
    end

    def set_eula_url
      @eula_url = Rails.application.secrets.eula_url
    end
end
