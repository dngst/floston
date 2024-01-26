# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  extend FriendlyId

  has_one :tenant, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :reminders, dependent: :destroy
  has_many :properties, dependent: :destroy

  accepts_nested_attributes_for :tenant

  validates :fname, :lname, :phone_number, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  def with_tenant
    build_tenant if tenant.nil?
    self
  end

  def name
    @name ||= "#{fname} #{lname}"
  end

  friendly_id :generate_slug, use: :slugged

  def generate_slug
    SecureRandom.hex(4)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email fname lname phone_number]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[comments requests tenant]
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fname                  :string           not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  lname                  :string           not null
#  paid                   :boolean          default(FALSE), not null
#  phone_number           :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  slug                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin_id               :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#
