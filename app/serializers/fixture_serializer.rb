class FixtureSerializer < ActiveModel::Serializer
  attributes :fixture_id, :home_team, :away_team, :match_day, :center_referee, :right_referee, :left_referee
  def fixture_id
    object.id
  end

  def home_team
    {
      id: object.home_team.id, 
      name: object.home_team.name,
      goals_for: object.result&.home_goals,
      points: object.result&.points(object.result&.home_goals, object.result&.away_goals)
    }
  end

  def away_team
    {
      id: object.away_team.id, 
      name: object.away_team.name,
      goals_for: object.result&.away_goals,
      points: object.result&.points(object.result&.away_goals, object.result&.home_goals)
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
