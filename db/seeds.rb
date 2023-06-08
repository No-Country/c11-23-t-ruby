admin = User.create!(
  email: "admin@demo.com",
  password: "123456",
  password_confirmation: "123456",
  role: "admin"
)

user_1 = User.create!(
  email: "user_1@demo.com",
  password: "123456",
  password_confirmation: "123456",
  role: "client"
)

user_2 = User.create!(
  email: "user_2@demo.com",
  password: "123456",
  password_confirmation: "123456",
  role: "client"
)

puts "Demo users has been created."

Account.create!(
  amount: 0,
  user: user_1
)

Account.create!(
  amount: 0,
  user: user_2
)

puts "user account has been created."
