user = User.create!(
  email: "user@demo.com",
  password: "123456",
  password_confirmation: "123456"
)

puts "Demo user has been created."

Account.create!(
  amount: 0,
  user: user
)

puts "user account has been created."
