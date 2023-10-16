class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:fname,
                                             :lname,
                                             :phone_number,
                                             :email,
                                             :password,
                                             :password_confirmation,
                                             :admin_id,
                                             { tenant_attributes:
                                               %i[unit_number
                                                  unit_type
                                                  moved_in
                                                  next_payment
                                                  amount_due] }])

    devise_parameter_sanitizer.permit(:account_update,
                                      keys: [:fname,
                                             :lname,
                                             :phone_number,
                                             { tenant_attributes:
                                               %i[amount_due
                                                  moved_in
                                                  next_payment
                                                  unit_number
                                                  unit_type] }])
  end

  def after_sign_in_path_for(resource)
    if resource.admin? && resource.sign_in_count == 1
      edit_user_registration_path
    elsif resource.admin?
      users_path
    elsif !resource.admin? && resource.sign_in_count == 1
      edit_user_registration_path
    else
      user_path(resource)
    end
  end
end
