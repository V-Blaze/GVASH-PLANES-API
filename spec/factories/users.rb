FactoryBot.define do
  factory :user do
    email { "user@example.com" }
    password { "password" }
    name { "User" }
  end
end
