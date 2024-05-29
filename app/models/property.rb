# frozen_string_literal: true

class Property < ApplicationRecord
  extend FriendlyId

  has_many :tenants
  has_many :articles
  has_many :requests
  belongs_to :user

  validates :name, presence: true

  broadcasts_refreshes

  INLINE_EDITABLE_ATTRS = %i[name].freeze

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def name
    self[:name].split.map(&:capitalize).join(' ') if self[:name]
  end

  def can_be_deleted?
    tenants.empty? && articles.empty?
  end

  def self.my_properties(current_user)
    where(user_id: current_user.id).order(:name)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end

# == Schema Information
#
# Table name: properties
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  slug          :string
#  tenants_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
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
