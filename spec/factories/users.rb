# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    admin { false }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
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
    fname { Faker::Name.first_name }
    lname { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
