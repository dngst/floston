elrich = User.create!(
  fname: "Erlich",
  lname: "Bachman",
  phone_number: "0715948650",
  email: "elrich@bachmanity.com",
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

duckman = User.create!(
  fname: "Duck",
  lname: "Man",
  phone_number: "0715948650",
  email: "duck@duckman.com",
  password: "password",
  admin_id: richard.id
)

Tenant.create!(
  user_id: duckman.id,
  unit_number: "B29",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2012",
  next_payment: "15-11-2012",
  amount_due: "10000",
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
  amount_due: "10000"
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
  amount_due: "10000"
)
