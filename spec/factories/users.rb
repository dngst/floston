# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    admin { false }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    fname { Faker::Internet.username }
    lname { Faker::Internet.username }
    phone_number { Faker::PhoneNumber.cell_phone }

    transient do
      tenant_attributes_override { {} }
    end

    tenant_attributes do
      {
        unit_number: Faker::Number.unique.number(digits: 3),
        unit_type: '3 Bedroom'
      }.merge(tenant_attributes_override)
    end
  end

  factory :admin, class: 'User' do
    admin { true }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    fname { Faker::Internet.username }
    lname { Faker::Internet.username }
    phone_number { Faker::PhoneNumber.cell_phone }
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
