class League < ApplicationRecord
  has_many :leagues_teams
  has_many :league_fixtures
  has_many :teams, through: :leagues_teams
  has_many :fixtures, through: :league_fixtures
end
