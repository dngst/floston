class Reminder < ApplicationRecord
  belongs_to :user

  validates :amount, presence: true
end

# == Schema Information
#
# Table name: reminders
#
#  id         :bigint           not null, primary key
#  amount     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_reminders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
