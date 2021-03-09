class UpdateUsersController < Devise::RegistrationsController
  def update_avatar
    if params[:user]
      current_user.update(permit_avatar)
    else
      current_user.update(avatar: nil)
    end

    redirect_to root_path, notice: "Avatar updated"
  end

  def update_email
    notice = 'Error in updating the email'

    if check_valid_password && params[:user][:email]
      update = current_user.update_without_password(permit_email)
      notice = 'Email updated' if update
    end

    redirect_to root_path, notice: notice
  end

  def update_password
    notice = 'Error in updating the password'

    if check_valid_password && params[:user][:password] == params[:user][:password_confirmation]
      update = current_user.update(permit_password)

      if update
        notice = 'Password changed'
        bypass_sign_in(current_user)
      end

    end

    redirect_to root_path, notice: notice
  end

  private

  def permit_avatar
    params.require(:user).permit(:avatar)
  end

  def permit_email
    params.require(:user).permit(:email)
  end

  def permit_password
    params.require(:user).permit(:password, :password_confirmation)
  end

  def check_valid_password
    current_user.valid_password?(params[:user][:current_password])
  end
end
