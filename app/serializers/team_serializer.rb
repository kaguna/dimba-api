class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location, :nickname

  belongs_to :league
  has_many :players
  has_many :commentaries
  has_many :home_team_fixtures, class_name: "Fixture", foreign_key: "home_team_id"
  has_many :away_team_fixtures, class_name: "Fixture", foreign_key: "away_team_id"
end
