class Team < ApplicationRecord
  validates :name, presence: true
  has_many :leagues_teams
end
