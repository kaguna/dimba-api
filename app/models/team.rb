class Team < ApplicationRecord
  has_many :players
  has_many :leagues_teams, dependent: :destroy
  has_many :leagues, through: :leagues_teams
  has_many :fixture_squads
  has_many :commentaries
  has_many :home_team_fixtures, class_name: "Fixture", foreign_key: "home_team_id"
  has_many :away_team_fixtures, class_name: "Fixture", foreign_key: "away_team_id"

  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false

  validates :nickname,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false
end
