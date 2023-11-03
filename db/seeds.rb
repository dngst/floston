require 'faker'

elrich = User.find_or_create_by!(
  fname: "Erlich",
  lname: "Bachman",
  phone_number: "0715948650",
  email: "erlich@bachmanity.com",
  admin: true
) do |user|
  user.password = "password"
end

richard = User.find_or_create_by!(
  fname: "Richard",
  lname: "Hendrix",
  phone_number: "0715948650",
  email: "richy@piedpipper.com",
  admin: true
) do |user|
  user.password = "password"
end

500.times do
  Property.create!(
    name: Faker::Address.street_name,
    user_id: elrich.id
  )
end

richards_property = Property.find_or_create_by!(
  name: "Viraj, Laikipia Road",
  user_id: richard.id
)

jackie = User.find_or_create_by!(
  fname: "Jackie",
  lname: "Brown",
  phone_number: "0715948650",
  email: "jackie@jackiebrown.com",
  admin_id: richard.id
) do |user|
  user.password = "password"
end

Tenant.find_or_create_by!(
  user_id: jackie.id,
  unit_number: "B29",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2012",
  next_payment: "15-11-2012",
  amount_due: "67",
  property_id: richards_property.id
)

john = User.find_or_create_by!(
  fname: "John",
  lname: "Doe",
  phone_number: "0715948650",
  email: "john.doe@example.com",
  admin_id: elrich.id
) do |user|
  user.password = "password"
end

Tenant.find_or_create_by!(
  user_id: john.id,
  unit_number: "B30",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2022",
  next_payment: "15-12-2022",
  amount_due: "67",
  property_id: 10
)

jane = User.find_or_create_by!(
  fname: "Jane",
  lname: "Doe",
  phone_number: "0715948650",
  email: "jane.doe@example.com",
  admin_id: elrich.id
) do |user|
  user.password = "password"
end

Tenant.find_or_create_by!(
  user_id: jane.id,
  unit_number: "B31",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2022",
  next_payment: "15-12-2022",
  amount_due: "67",
  property_id: 10
)

Article.find_or_create_by!(
  title: "Recent change of management",
  body: "Following a recent incident, some changes have been made...",
  user_id: elrich.id,
  published: true,
  property_id: 10
)

Article.find_or_create_by!(
  title: "Key people at Argon Properties",
  body: "Some of the names and contacts of the people involved in this project...",
  user_id: elrich.id,
  published: true,
  property_id: 10
)

Article.find_or_create_by!(
  title: "Faulty tap at the parking lot near block D",
  body: "There's a licking tap near block D at the parking lot. Please refrain
   from using it while we organise for repairs to be made.",
  user_id: elrich.id,
  property_id: 10
)

Article.find_or_create_by!(
  title: "Richard can also write some articles like this one",
  body: "Jobs or... Jobs",
  user_id: richard.id,
  published: true,
  property_id: richards_property.id
)

Request.find_or_create_by!(
  title: "Window repair",
  description: "Woke up this morning to find a window pane in my bedroom had fallen down",
  user_id: jane.id
)

Request.find_or_create_by!(
  title: "Disturbance",
  description: "The tenant at door no. 2E is constatly playing loud music since they moved in and is rude when asked to tone it down.",
  user_id: jane.id
)

Request.find_or_create_by!(
  title: "Key replacement",
  description: "I lost my gate key. Could you please organise for me another one?",
  user_id: john.id
)

24.times do
  Reminder.create!(
    amount: "67",
    user_id: jane.id
  )
end

500.times do
  unit_number = Faker::Number.unique.number(digits: 3)

  existing_tenant = Tenant.find_by(unit_number: unit_number)

  if existing_tenant.nil?
    user = User.create!(
      fname: Faker::Internet.username,
      lname: Faker::Internet.username,
      phone_number: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email,
      admin_id: elrich.id
    ) do |user|
      user.password = "password"
    end

    Tenant.create!(
      user_id: user.id,
      unit_number: unit_number,
      unit_type: "1 Bedroom",
      moved_in: "15-11-2022",
      next_payment: "15-12-2022",
      amount_due: "67",
      property_id: 10
    )
  else
    puts "Tenant with unit_number #{unit_number} already exists. Skipping..."
  end
end

500.times do
  Request.create!(
    title: Faker::Lorem.words(number: 5).join(' '),
    description: Faker::Lorem.paragraphs(number: 5, supplemental: true).join("\n\n"),
    user_id: jane.id
  )
end

500.times do
  Article.create!(
    title: Faker::Lorem.words(number: 7).join(' '),
    body:  Faker::Lorem.paragraphs(number: 5, supplemental: true).join("\n\n"),
    user_id: elrich.id,
    property_id: 10,
    published: true
  )
end
