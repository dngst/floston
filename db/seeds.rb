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

50.times do
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
  amount_due: 68.90,
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
  amount_due: 68.90,
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
  amount_due: 68.90,
  property_id: 10
)

24.times do
  Reminder.create!(
    amount: 68.90,
    user_id: jane.id
  )
end

50.times do
  unit_number = Faker::Number.unique.number(digits: 3)

  existing_tenant = Tenant.find_by(unit_number: unit_number)

  if existing_tenant.nil?
    user = User.create!(
      fname: Faker::Name.first_name,
      lname: Faker::Name.last_name,
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
      amount_due: 68.90,
      property_id: 10
    )
  else
    puts "Tenant with unit_number #{unit_number} already exists. Skipping..."
  end
end

50.times do
  Request.create!(
    title: Faker::Lorem.words(number: 5).join(' '),
    description: Faker::Lorem.paragraphs(number: 5, supplemental: true).join("\n\n"),
    user_id: jane.id,
    property_id: 10
  )
end
