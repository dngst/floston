# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    name { Faker::Address.street_name }
  end
end
