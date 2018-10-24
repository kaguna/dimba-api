class League < ApplicationRecord
  has_many :leagues_teams
  has_many :teams, through: :leagues_teams
end
