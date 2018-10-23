FactoryBot.define do
  factory :player, class: Player do
    first_name { Faker::Name.male_first_name }
    second_name { Faker::Name.name_with_middle }
    last_name { Faker::Name.last_name }
    nick_name { Faker::FunnyName.name }
    dob { Faker::Time.between(29.years.ago, 19.years.ago) }
    id_number { Faker::IDNumber.spanish_citizen_number }
    phone_number { Faker::PhoneNumber.phone_number }
  end
end
