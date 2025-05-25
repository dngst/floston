# frozen_string_literal: true

class Request < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :property

  validates :title, :description, presence: true

  broadcasts_refreshes

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[description title]
  end

  def self.ransackable_associations(auth_object = nil)
    ["comments", "property", "user"]
  end
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
