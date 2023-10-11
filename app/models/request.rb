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
  has_many :comments, dependent: :destroy

  validates :title, :description, presence: true

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[description title]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments user]
  end
end
