FactoryBot.define do
  factory :user, class: User do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
