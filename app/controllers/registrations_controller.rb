class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :check_admin, only: [:new, :create]
  skip_before_action :require_no_authentication

  private

  def check_admin
    unless current_user&.admin?
      flash[:alert] = "You do not have permission to access this page."
      redirect_to root_path
    end
  end
end
