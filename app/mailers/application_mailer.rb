# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  sender = Rails.application.credentials.dig(:smtp, :user_name) || ENV["SMTP_USERNAME"]
  default from: email_address_with_name(sender, "Floston Notification")
  layout "mailer"
end
