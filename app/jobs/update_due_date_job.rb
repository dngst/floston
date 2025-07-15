class UpdateDueDateJob < ApplicationJob
  queue_as :default

  def perform
    Tenant.where.not(next_payment: nil).find_each do |tenant|
      tenant.update!(next_payment: tenant.next_payment.next_month)
    end
  end
end
