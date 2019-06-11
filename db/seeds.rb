# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

roles = [:Admin, :Referee, :Official, :Coach, :Sponsor, :Player, :User]
events = [:Goal, :Yellow, :Red, :Assist, :Corner, :Penalty, :Injury]

def create_season(from, to)
  seasons = []
  (from..to).each do |any_year|
    season = "#{ any_year }/#{any_year + 1}"
    seasons.push(season)
  end
  seasons
end

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

(events.length).times do |i|
  Event.create(
      name: events[i],
      description: Faker::Lorem.paragraph
  )
end

create_season(2015, 2018).each do |season|
  Season.create(
      name: season,
      description: Faker::Lorem.paragraph,
      duration: 1
  )
end
