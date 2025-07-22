# frozen_string_literal: true

class Request < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :property

  validates :title, :description, presence: true

  broadcasts_refreshes

  friendly_id :generate_slug, use: :slugged

  scope :by_user_scope, ->(user) { by_user_query(user) }

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[description title]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments property user]
  end

  def self.by_user_query(user)
    if user.admin?
      joins(:user).where(users: { admin_id: user.id }).order(created_at: :desc)
    else
      where(user_id: user.id).order(created_at: :desc)
    end
  end
end
