class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :check_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  def create
    if current_user&.admin?
      # create a user without automatically signing them in
      self.resource = resource_class.new(sign_up_params)
      if resource.save
        set_flash_message! :notice, :signed_up
        redirect_to after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      flash[:alert] = "You do not have permission to create an account."
      redirect_to root_path
    end
  end

  private

  def check_admin
    unless current_user&.admin?
      flash[:alert] = "You do not have permission to access this page."
      redirect_to root_path
    end
  end
end
