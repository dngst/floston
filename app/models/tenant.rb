# frozen_string_literal: true

class Tenant < ApplicationRecord
  belongs_to :user
  belongs_to :property, counter_cache: true

  validates :unit_number, presence: true, uniqueness: true
  validates :unit_type, presence: true

  broadcasts_refreshes

  UNIT_TYPES = [
    'Studio',
    'Bedsitter',
    '1 Bedroom',
    '2 Bedroom',
    '3 Bedroom',
    '4 Bedroom',
    '5 Bedroom',
    '6 Bedroom',
    '7 Bedroom',
    '8 Bedroom +'
  ].freeze

  def self.unit_types
    UNIT_TYPES
  end

  scope :due_for_reminder, -> { where(next_payment: ..5.days.from_now) }

  def self.send_due_date_reminders
    due_for_reminder.find_each do |tenant|
      Reminder.create!(amount: tenant.amount_due, user_id: tenant.user.id) if PaymentDueMailer.reminder_email(tenant.user, tenant).deliver_now
    end
  end

  def self.total_amount_due(current_user)
    return unless current_user&.admin?

    tenants = joins(:user).where(users: { admin_id: current_user.id }).where.not(amount_due: nil)
    tenants.sum(:amount_due)
  end

  def self.update_due_dates
    Tenant.where.not(next_payment: nil).find_each do |tenant|
      tenant.update!(next_payment: tenant.next_payment.next_month)
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[unit_number unit_type property]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[property user]
  end
end

# == Schema Information
#
# Table name: tenants
#
#  id           :bigint           not null, primary key
#  amount_due   :decimal(8, 2)
#  moved_in     :date
#  next_payment :date
#  unit_number  :string           not null
#  unit_type    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  property_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_tenants_on_property_id  (property_id)
#  index_tenants_on_unit_number  (unit_number) UNIQUE
#  index_tenants_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#  fk_rails_...  (user_id => users.id)
#
