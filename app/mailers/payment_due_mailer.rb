class PaymentDueMailer < ApplicationMailer
  def reminder_email(user, tenant)
    @user = user
    @tenant = tenant
    mail(to: @user.email, subject: 'Your next payment is due in 5 days')
  end
end
