class FixtureSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :match, :results
  has_many :commentaries

  def match
    {
      fixture_id: self.object.id,
      home_team: [self.object.home_team.id, self.object.home_team.name], 
      away_team: [self.object.away_team.id, self.object.away_team.name],
      match_day: self.object.match_day,
      center_referee: self.object.center_referee,
      right_side_referee: self.object.right_side_referee,
      left_side_referee: self.object.left_side_referee
    }
  end

  def results
    {"link": api_v1_standings_path(league_id: self.object.league_id, season_id: self.object.season_id)}
  end
end
