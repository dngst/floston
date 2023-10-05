john = User.create!(
  fname: "John",
  lname: "Doe",
  phone_number: "0715948650",
  email: "john.doe@example.com",
  password: "password",
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
)

Tenant.create!(
  user_id: jane.id,
  unit_number: "B31",
  unit_type: "1 Bedroom",
  moved_in: "15-11-2022",
  next_payment: "15-12-2022",
  amount_due: "10000"
)

admin = User.create!(
  fname: "Erlich",
  lname: "Bachman",
  phone_number: "0715948650",
  email: "elrich@bachmanity.com",
  password: "password",
  admin: true
)

Tenant.create!(
  user_id: admin.id,
  unit_number: "0",
  unit_type: "0",
  moved_in: "15-11-2012",
  next_payment: "15-11-2012",
  amount_due: "0",
)
