class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :title, :season

  has_many :teams, through: :leagues_teams
  has_many :sponsors, through: :leagues_sponsors
  has_many :fixtures
end
