# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :description }
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :comments }
end

# == Schema Information
#
# Table name: requests
#
#  id          :bigint           not null, primary key
#  closed      :boolean          default(FALSE), not null
#  description :text             not null
#  slug        :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :integer
#  user_id     :bigint           not null
#
# Indexes
#
#  index_requests_on_slug     (slug) UNIQUE
#  index_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
