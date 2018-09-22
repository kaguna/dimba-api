FactoryBot.define do
  factory :user, class: User do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    role { Faker::Number.between(1, 4) }
    password { Faker::Internet.password }
  end
end
