# == Schema Information
#
# Table name: properties
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_properties_on_slug     (slug) UNIQUE
#  index_properties_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Property < ApplicationRecord
  extend FriendlyId

  validates :name, presence: true

  has_many :tenants
  has_many :articles

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def can_delete_property?
    can_delete_property ||= tenants.empty? && articles.empty?
  end

  def self.my_properties(current_user)
    Property.where(user_id: current_user.id)
  end

  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end
end
