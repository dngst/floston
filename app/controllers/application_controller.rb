# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include OnlineStatusHelper
  helper_method :online?

  before_action :configure_permitted_parameters, if: :devise_controller?

  unless Rails.env.production?
    around_action :n_plus_one_detection

    def n_plus_one_detection
      Prosopite.scan
      yield
    ensure
      Prosopite.finish
    end
  end

  protected

  def configure_permitted_parameters
    keys_common = %i[fname lname phone_number]
    keys_sign_up = keys_common + [:email, :password, :password_confirmation, :admin_id, { tenant_attributes: }]
    keys_account_update = keys_common + [tenant_attributes: tenant_attributes(update: true)]

    devise_parameter_sanitizer.permit(:sign_up, keys: keys_sign_up)
    devise_parameter_sanitizer.permit(:account_update, keys: keys_account_update)
  end

  def tenant_attributes(update: false)
    if update
      %i[amount_due moved_in next_payment unit_number unit_type]
    else
      %i[unit_number unit_type moved_in next_payment amount_due property_id]
    end
  end

  def after_sign_in_path_for(resource)
    return edit_user_registration_path if resource.sign_in_count == 1

    resource.admin? ? users_path : user_path(resource)
  end
end
