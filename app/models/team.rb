class Team < ApplicationRecord
  has_many :players
  has_many :leagues_teams, dependent: :destroy
  has_many :leagues, through: :leagues_teams
  has_many :fixture_squads
  has_many :commentaries
  has_many :from_team_transfers, class_name: "Transfer", foreign_key: "from_team_id"
  has_many :to_team_transfers, class_name: "Transfer", foreign_key: "to_team_id"
  has_many :home_team_fixtures, class_name: "Fixture", foreign_key: "home_team_id"
  has_many :away_team_fixtures, class_name: "Fixture", foreign_key: "away_team_id"
  belongs_to :coach, class_name: "User", foreign_key: "coach_id"

  validates :name,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false

  validates :nickname,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false

  def self.search(search_value)
    self.where("LOWER(name) LIKE ? or LOWER(nickname) LIKE ?", 
                "%#{search_value.downcase}%", "%#{search_value.downcase}%"
              )
  end
end
