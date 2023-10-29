# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  body        :text             not null
#  published   :boolean          default(FALSE), not null
#  slug        :string
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  property_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_property_id  (property_id)
#  index_articles_on_slug         (slug) UNIQUE
#  index_articles_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (property_id => properties.id)
#  fk_rails_...  (user_id => users.id)
#
class Article < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  belongs_to :property

  INLINE_EDITABLE_ATTRS = %i[title body property_id published].freeze

  validates :title, :body, presence: true

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[body title]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end
end
