class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name('eddieatse@gmail.com', 'Floston Notification')
  layout 'mailer'
end
