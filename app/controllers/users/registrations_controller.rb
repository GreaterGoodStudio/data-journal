class Users::RegistrationsController < Devise::RegistrationsController
  def update
    if update_resource(current_user, account_update_params)
      if params[:user][:avatar].present?
        redirect_to edit_user_avatar_path
      else
        redirect_to edit_user_registration_path, notice: "Profile updated."
      end
    else
      render :edit, error: current_user.errors.full_messages.to_sentence
    end
  end

  def update_avatar
    if update_resource(current_user, avatar_crop_params)
      if params[:invited].present?
        redirect_to root_path, notice: "Welcome to Data Journal."
      else
        redirect_to edit_user_registration_path, notice: "Profile updated."
      end
    else
      render :edit, error: current_user.errors.full_messages.to_sentence
    end
  end

  protected

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

  private

    def account_update_params
      devise_parameter_sanitizer.sanitize(:account_update)
    end

    def avatar_crop_params
      params.require(:user).permit(:crop_x, :crop_y, :crop_w, :crop_h)
    end
end
