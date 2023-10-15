# == Schema Information
#
# Table name: requests
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  slug        :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
require 'rails_helper'

RSpec.describe Request do
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should belong_to :user }
  it { should have_many :comments }
end
