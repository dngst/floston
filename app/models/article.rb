# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  published  :boolean          default(FALSE), not null
#  slug       :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :integer          not null
#
# Indexes
#
#  index_articles_on_slug  (slug) UNIQUE
#
class Article < ApplicationRecord
  extend FriendlyId

  INLINE_EDITABLE_ATTRS = %i[title body published]

  validates :title, :body, :admin_id, presence: true

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[body title]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
