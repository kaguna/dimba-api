FactoryBot.define do

  factory :transfer, class: Transfer do
    transfer_comment { Faker::Lorem.paragraph }
    transfer_budget { Faker::Number.number(4) }
    contract_time { Faker::Number.between(1, 5) }
  end
end