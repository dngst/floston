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

Article.create!(
  title: "Recent change of management",
  body: "Following a recent incident, some changes have been made...",
  admin_id: elrich.id,
  published: true
)

Article.create!(
  title: "Key people at Argon Properties",
  body: "Some of the names and contacts of the people involved in this project...",
  admin_id: elrich.id,
  published: true
)

Article.create!(
  title: "Faulty tap at the parking lot near block D",
  body: "There's a licking tap near block D at the parking lot. Please refrain
   from using it while we organise for repairs to be made.",
  admin_id: elrich.id
)

Article.create!(
  title: "Richard can also write some articles like this one",
  body: "Jobs or... Jobs",
  admin_id: richard.id,
  published: true
)
