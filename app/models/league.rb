class League < ApplicationRecord
  has_many :fixtures, dependent: :destroy
  has_many :leagues_teams, dependent: :destroy
  has_many :teams, through: :leagues_teams
  has_many :leagues_sponsors, dependent: :destroy
  has_many :sponsors, through: :leagues_sponsors
end
