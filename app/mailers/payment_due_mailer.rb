class PaymentDueMailer < ApplicationMailer
  def reminder_email(user, tenant)
    @user = user
    @tenant = tenant
    mail(to: @user.email, subject: t('mailer.payment_due.subject'))
  end
end
