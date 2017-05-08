class Users::InvitationsController < Devise::InvitationsController
  private

    def after_accept_path_for(_resource)
      flash.clear
      edit_user_avatar_path(invited: true)
    end
end
