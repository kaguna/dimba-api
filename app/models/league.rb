class League < ApplicationRecord
  has_and_belongs_to_many :teams
  has_many :teams, through: :leagues_teams
end
