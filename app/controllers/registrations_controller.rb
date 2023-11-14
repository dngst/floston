class RegistrationsController < Devise::RegistrationsController
  include RequireAdmin

  before_action :authenticate_user!, :require_admin, only: %i[new create]
  skip_before_action :require_no_authentication

  def create
    if current_user&.admin?
      # Create a user without automatically signing them in
      self.resource = resource_class.new(sign_up_params)
      # Generate an 8-character random password
      generated_password = Devise.friendly_token.first(8)
      resource.password = generated_password

      if resource.save
        set_flash_message! :notice, :signed_up
        Rails.cache.delete('tenant_ids')
        NewUserMailer.login_credentials(resource, generated_password).deliver_later
        redirect_to after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    else
      flash[:alert] = t('registrations.permission_denied')
      redirect_to root_path
    end
  end
end
