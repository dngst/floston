# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/payment_due_mailer
class PaymentDueMailerPreview < ActionMailer::Preview
  def reminder_email
    user = User.new(email: 'john.doe@example.com', fname: 'John', id: 1)
    tenant = Tenant.new(next_payment: '15-11-2012', amount_due: '750')
    PaymentDueMailer.reminder_email(user, tenant)
  end
end
