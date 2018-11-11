FactoryBot.define do
  factory :fixture_squad, class: FixtureSquad do

    playing { Faker::Boolean.boolean }

  end
end
