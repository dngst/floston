class SendDueDateReminderJob < ApplicationJob
  queue_as :default

  def perform
    Tenant.send_due_date_reminders
  end
end
