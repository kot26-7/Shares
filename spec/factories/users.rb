FactoryBot.define do
  factory :user do
    fullname { "test" }
    username { "test1" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "password" }
  end
end