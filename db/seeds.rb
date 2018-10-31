# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
20.times do
  Team.create(
    name: Faker::Football.team,
    description: Faker::Lorem.sentence,
    location: Faker::Address.city,
    nickname: Faker::Hobbit.character
  )
end

teams = Team.all.pluck(:id)
teams.each do |id|
  15.times do
    Player.create(
      first_name: Faker::Name.first_name, 
      second_name: Faker::Name.middle_name,
      last_name: Faker::Name.last_name,
      nick_name: Faker::Football.player,
      id_number: Faker::IDNumber.spanish_citizen_number,
      dob: Faker::Date.birthday(19, 38),
      phone_number: Faker::PhoneNumber.cell_phone,
      team_id: id
    )
  end
end

6.times do
  League.create(
      title: Faker::Football.competition,
      season: Faker::Name.middle_name,
      )
end

roles = [:Admin, :Referee, :Official, :Coach, :Sponsor, :Player, :User]


(roles.length).times do |i|
  Role.create(
      name: roles[i],
      description: Faker::Lorem.paragraph
  )
end

10.times do
  Sponsor.create(
    name: Faker::Bank.name,
    description: Faker::Lorem.paragraph,
    contacts: Faker::Internet.url
  )
  end
