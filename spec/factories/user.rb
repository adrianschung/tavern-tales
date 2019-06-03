FactoryBot.define do
  factory :user do
    username { 'user' }
    sequence :email do |n|
      "email#{n}@email.com"
    end
    password { 'password' }
  end
end