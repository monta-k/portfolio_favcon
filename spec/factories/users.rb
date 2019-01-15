FactoryBot.define do
  factory :user do
    username { "TestUser" }
    email { "test@email.com" }
    password { "password" }
    password_confirmation { "password" }
  end
end
