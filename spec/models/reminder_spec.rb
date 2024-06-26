# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reminder do
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to belong_to :user }
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
