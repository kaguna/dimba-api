class FixtureSerializer < ActiveModel::Serializer
  attributes :fixture_id, :home_team, :away_team, :match_day, :center_referee, :right_referee, :left_referee
  def fixture_id
    object.id
  end

  def full_match_results
    object&.full_match_results(object.id)
  end

  def home_team
    {
      id: object.home_team.id, 
      name: object.home_team.name,
      goals_for: full_match_results.nil? ? nil : full_match_results[:home_team][:goals_for],
      points: full_match_results.nil? ? nil : full_match_results[:home_team][:points],
      coach: object.home_team&.coach&.id
    }
  end

  def away_team
    {
      id: object.away_team.id, 
      name: object.away_team.name,
      goals_for: full_match_results.nil? ? nil : full_match_results[:away_team][:goals_for],
      points: full_match_results.nil? ? nil : full_match_results[:away_team][:points],
      coach: object.away_team&.coach&.id
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
end
