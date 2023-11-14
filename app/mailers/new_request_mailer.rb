class NewRequestMailer < ApplicationMailer
  def request_notification(user, request)
    @user = user
    @request = request
    mail(to: @user.email, subject: t('mailer.new_request'))
  end
end
