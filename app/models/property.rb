# frozen_string_literal: true

class Property < ApplicationRecord
  extend FriendlyId

  has_many :tenants
  has_many :requests
  belongs_to :user

  validates :name, presence: true

  broadcasts_refreshes

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def name
    self[:name].split.map(&:capitalize).join(' ') if self[:name]
  end

  def can_be_deleted?
    tenants.empty?
  end

  def self.my_properties(current_user)
    where(user_id: current_user.id).order(:name)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[name]
  end
end
