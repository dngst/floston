# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  serialize :viewed_user_ids, Array

  belongs_to :user
  belongs_to :property

  validates :title, :body, presence: true

  INLINE_EDITABLE_ATTRS = %i[title body property_id published].freeze

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def user_has_viewed?(user)
    viewed_user_ids.include?(user.id)
  end

  def mark_as_viewed_by_user(user)
    return if user_has_viewed?(user) || user.admin?

    new_view_count = view_count + 1
    update(view_count: new_view_count, viewed_user_ids: viewed_user_ids << user.id)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[body title property]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user property]
  end
end

# == Schema Information
#
# Table name: articles
#
#  id              :bigint           not null, primary key
#  body            :text             not null
#  published       :boolean          default(FALSE), not null
#  slug            :string
#  title           :string           not null
#  viewed_user_ids :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  property_id     :bigint           not null
#  user_id         :bigint           not null
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
