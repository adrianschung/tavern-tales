5.times do |i|
  User.create!(username: "user#{i}", email: "email#{i}@email.com", password: "password")
end