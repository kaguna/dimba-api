class FixtureSerializer < ActiveModel::Serializer
  attributes :match

  def match
    {
      fixture_id: self.object.id,
      home_team: [self.object.home_team.id, self.object.home_team.name], 
      away_team: [self.object.away_team.id, self.object.away_team.name],
      match_day: self.object.match_day,
      squad: self.squad,
      referees: self.referees,
      commentaries: self.commentaries,
      results: self.results
    }
  end

  def match_players
    object.fixture_squad.map do |fixture_squad| 
      FixtureSquadSerializer.new(fixture_squad).squad
    end
  end

  def home_team_squad
    self.match_players.select do |team|
      team[:team] == self.object.home_team.id
    end
  end

  def away_team_squad
    self.match_players.select do |team|
      team[:team] == self.object.away_team.id
    end
  end

  def squad
    {
      home_team: self.home_team_squad,
      away_team: self.away_team_squad
    }
  end

  def commentaries
    object.commentaries.map do |commentaries| 
      CommentarySerializer.new(commentaries).commentary
    end
  end

  def referees
    {
      center: self.object.center_referee,
      right: self.object.right_side_referee,
      left: self.object.left_side_referee
    }
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
