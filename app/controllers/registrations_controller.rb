# Devise
class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(response)
    '/complaints/' # Or :prefix_to_your_route
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :email, :password,
                                 :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :email, :password,
                                 :password_confirmation, :current_password)
  end
end
