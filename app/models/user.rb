# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include AdminScopable
  extend FriendlyId

  has_one :tenant, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :properties, dependent: :destroy

  accepts_nested_attributes_for :tenant

  validates :fname, :lname, :phone_number, presence: true

  broadcasts_refreshes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  scope :tenants_for, ->(admin_id) { where(admin: false, admin_id: admin_id).order(created_at: :desc).includes(:tenant) }

  def with_tenant
    build_tenant unless tenant
    self
  end

  def name
    "#{fname.capitalize} #{lname.capitalize}"
  end

  friendly_id :generate_slug, use: :slugged

  ransacker :full_name do |parent|
    Arel::Nodes::NamedFunction.new('CONCAT_WS', [
                                     Arel::Nodes.build_quoted(' '), parent.table[:fname], parent.table[:lname]
                                   ])
  end

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email fname lname phone_number full_name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments requests tenant]
  end
end
