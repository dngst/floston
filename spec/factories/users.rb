FactoryBot.define do
  factory :user do
    admin { false }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    fname { Faker::Internet.username }
    lname { Faker::Internet.username }
    phone_number { Faker::PhoneNumber.cell_phone }
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
