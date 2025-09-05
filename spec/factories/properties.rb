# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    name { Faker::Address.street_name }
    amount_due { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
