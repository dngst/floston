class NewUserMailer < ApplicationMailer
  def login_credentials(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: t('mailer.new_user'))
  end
end
