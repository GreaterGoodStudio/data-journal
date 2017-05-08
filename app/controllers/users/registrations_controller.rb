class Users::RegistrationsController < Devise::RegistrationsController
  def update
    @user = current_user
    if params[:user][:avatar].present? && update_resource(@user, account_update_params)
      render :crop
    elsif params[:user][:crop_x].present? && @user.update_without_password(avatar_crop_params)
      redirect_to edit_user_registration_path, notice: "Profile updated."
    else
      render :edit, error: @user.errors.full_messages.to_sentence
    end
  end

  private

    def account_update_params
      devise_parameter_sanitizer.sanitize(:account_update)
    end

    def avatar_crop_params
      params.require(:user).permit(:crop_x, :crop_y, :crop_w, :crop_h)
    end
end