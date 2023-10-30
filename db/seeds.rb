require 'faker'

elrich = User.create!(
  fname: "Erlich",
  lname: "Bachman",
  phone_number: "0715948650",
  email: "erlich@bachmanity.com",
  password: "password",
  admin: true
)

richard = User.create!(
  fname: "Richard",
  lname: "Hendrix",
  phone_number: "0715948650",
  email: "richy@piedpipper.com",
  password: "password",
  admin: true
)

50.times do
  Property.create!(
    name: Faker::Address.street_name,
    user_id: elrich.id
  )
end

richards_property = Property.create!(
  name: Faker::Address.unique.street_name,
  user_id: richard.id
)

jackie = User.create!(
  fname: "Jackie",
  lname: "Brown",
  phone_number: "0715948650",
  email: "jackie@jackiebrown.com",
  password: "password",
  admin_id: richard.id
)

Tenant.create!(
  user_id: jackie.id,
  unit_number: "B29",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2012",
  next_payment: "15-11-2012",
  amount_due: "10000",
  property_id: richards_property.id
)

john = User.create!(
  fname: "John",
  lname: "Doe",
  phone_number: "0715948650",
  email: "john.doe@example.com",
  password: "password",
  admin_id: elrich.id
)

Tenant.create!(
  user_id: john.id,
  unit_number: "B30",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2022",
  next_payment: "15-12-2022",
  amount_due: "10000",
  property_id: Property.last.id
)

jane = User.create!(
  fname: "Jane",
  lname: "Doe",
  phone_number: "0715948650",
  email: "jane.doe@example.com",
  password: "password",
  admin_id: elrich.id
)

Tenant.create!(
  user_id: jane.id,
  unit_number: "B31",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2022",
  next_payment: "15-12-2022",
  amount_due: "10000",
  property_id: Property.last.id
)

Article.create!(
  title: "Recent change of management",
  body: "Following a recent incident, some changes have been made...",
  user_id: elrich.id,
  published: true,
  property_id: Property.last.id
)

Article.create!(
  title: "Key people at Argon Properties",
  body: "Some of the names and contacts of the people involved in this project...",
  user_id: elrich.id,
  published: true,
  property_id: Property.last.id
)

Article.create!(
  title: "Faulty tap at the parking lot near block D",
  body: "There's a licking tap near block D at the parking lot. Please refrain
   from using it while we organise for repairs to be made.",
  user_id: elrich.id,
  property_id: Property.last.id
)

Article.create!(
  title: "Richard can also write some articles like this one",
  body: "Jobs or... Jobs",
  user_id: richard.id,
  published: true,
  property_id: Property.last.id
)

Request.create!(
  title: "Window repair",
  description: "Woke up this morning to find a window pane in my bedroom had fallen down",
  user_id: jane.id
)

Request.create!(
  title: "Disturbance",
  description: "The tenant at door no. 2E is constatly playing loud music since they moved in and is rude when asked to tone it down.",
  user_id: jane.id
)

Request.create!(
  title: "Key replacement",
  description: "I lost my gate key. Could you please organise for me another one?",
  user_id: john.id
)

15.times do
  Reminder.create!(
    amount: "62104",
    user_id: jane.id
  )
end

50.times do
  user = User.create!(
    fname: Faker::Internet.username,
    lname: Faker::Internet.username,
    phone_number: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    password: "password",
    admin_id: elrich.id
  )

  Tenant.create!(
    user_id: user.id,
    unit_number: Faker::Number.unique.number(digits: 3),
    unit_type: "1 Bedroom",
    moved_in: "15-11-2022",
    next_payment: "15-12-2022",
    amount_due: "10000",
    property_id: Property.last.id
  )
end


50.times do
  Request.create!(
    title: Faker::Lorem.words(number: 5).join(' '),
    description: Faker::Lorem.paragraphs(number: 5, supplemental: true).join("\n\n"),
    user_id: jane.id
  )
end

50.times do
  Article.create!(
    title: Faker::Lorem.words(number: 7).join(' '),
    body:  Faker::Lorem.paragraphs(number: 5, supplemental: true).join("\n\n"),
    user_id: elrich.id,
    property_id: Property.last.id,
    published: true
  )
end
