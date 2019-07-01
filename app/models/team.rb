class Team < ApplicationRecord
  validates :name, presence: true
  has_many :players
  has_many :leagues_teams, dependent: :destroy
  has_many :leagues, through: :leagues_teams
  has_many :fixture_squads
end
