# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  include RequireAdmin

  before_action :authenticate_user!, :require_admin, only: %i[new create]
  skip_before_action :require_no_authentication

  def create
    unless current_user&.admin?
      flash[:alert] = t("registrations.permission_denied")
      redirect_to root_path
    end
    # create a user without automatically signing them in
    self.resource = resource_class.new(sign_up_params)
    # generate an 8-character random password
    generated_password = Devise.friendly_token.first(8)
    resource.password = generated_password

    if resource.save
      NewUserMailer.login_credentials(resource, generated_password).deliver_now
      redirect_to after_sign_up_path_for(resource)
    else
      respond_with resource
    end
  end
end
