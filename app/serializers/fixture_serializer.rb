class FixtureSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :match

  belongs_to :user
  has_many :commentaries

  def match
    {
      fixture_id: self.object.id,
      home_team: [self.object.home_team.id, self.object.home_team.name], 
      away_team: [self.object.away_team.id, self.object.away_team.name],
      match_day: self.object.match_day,
      center_referee: self.object.center_referee,
      right_side_referee: self.object.right_side_referee,
      left_side_referee: self.object.left_side_referee,
      commentaries: self.commentaries,
      results: self.results
    }
  end

  def commentaries
    object.commentaries.map do |commentaries| 
      CommentarySerializer.new(commentaries).commentary
    end
  end

  def get_results
    Standings::Statistics.new(league_id: self.object.league_id,
      season_id: self.object.season_id).league_stats[:results]
        
  end

  def results
    self.get_results.find do |result|
      result[:fixture_id] == self.object.id
    end
  end
end
