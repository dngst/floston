class NewUserMailer < ApplicationMailer
  def login_credentials(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: 'Your login credentials - Propfolio')
  end
end
