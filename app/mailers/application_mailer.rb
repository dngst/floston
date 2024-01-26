# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name('floston.relations@gmail.com', 'Floston Notification')
  layout 'mailer'
end
