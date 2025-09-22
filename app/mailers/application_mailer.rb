# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name(Rails.application.credentials.dig(:smtp, :user_name), "Floston Notification")
  layout "mailer"
end
