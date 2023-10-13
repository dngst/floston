class NewRequestMailer < ApplicationMailer
  def request_notification(user, request)
    @user = user
    @request = request
    mail(to: @user.email, subject: 'New tenant request - Propfolio')
  end
end
