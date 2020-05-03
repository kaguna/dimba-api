class FixtureSerializer < ActiveModel::Serializer
  attributes :id, :home_team, :away_team, :match_day, :center_referee, :right_referee, :left_referee
  
  def home_team
    {
      id: object.home_team.id, 
      name: object.home_team.name
    }
  end

  def away_team
    {
      id: object.away_team.id, 
      name: object.away_team.name
    }
  end

  def center_referee
    {
      id: object.center_referee&.id,
      name: object.center_referee&.username
    }
  end

  def right_referee
    {
      id: object.right_side_referee&.id,
      name: object.right_side_referee&.username
    }
  end

  def left_referee
    {
      id: object.left_side_referee&.id,
      name: object.left_side_referee&.username
    }
  end

  # def player
  #   {
  #     id: object.player.id, 
  #     name: player_full_name
  #   }
  # end

  # def player_full_name
  #   object.player.nick_name # eventually it will be unique.
  # end

  # def match_players
  #   object.fixture_squad.map do |fixture_squad| 
  #     FixtureSquadSerializer.new(fixture_squad).squad
  #   end
  # end

  # def home_team_squad
  #   self.match_players.select do |team|
  #     team[:team] == self.object.home_team.id
  #   end
  # end

  # def away_team_squad
  #   self.match_players.select do |team|
  #     team[:team] == self.object.away_team.id
  #   end
  # end

  # def squad
  #   {
  #     home_team: self.home_team_squad,
  #     away_team: self.away_team_squad
  #   }
  # end

  # def commentaries
  #   object.commentaries.map do |commentaries| 
  #     CommentarySerializer.new(commentaries).commentary
  #   end
  # end

  # def get_results
  #   Standings::Statistics.new(league_id: self.object.league_id,
  #     season_id: self.object.season_id).league_stats[:results]
  # end

  # def results
  #   self.get_results.find do |result|
  #     result[:fixture_id] == self.object.id
  #   end
  # end
end
