user_1 = User.create!(
  email: "user_1@demo.com",
  password: "123456",
  password_confirmation: "123456"
)

user_2 = User.create!(
  email: "user_2@demo.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "Demo users has been created."

Account.create!(
  amount: 0,
  user: user_1
)

puts "user account has been created."
