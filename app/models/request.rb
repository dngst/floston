# == Schema Information
#
# Table name: requests
#
#  id          :bigint           not null, primary key
#  description :text
#  slug        :string
#  title       :string
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
class Request < ApplicationRecord
  extend FriendlyId

  belongs_to :user

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end
end
