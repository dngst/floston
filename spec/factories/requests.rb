FactoryBot.define do
  factory :request do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
  end
end