class FixtureSerializer < ActiveModel::Serializer
  attributes :fixture_id, :home_team, :away_team, :match_day, :center_referee, :right_referee,
              :left_referee, :played, :fixture_season, :fixture_league
  attribute :postponed
  attribute :submit_results
  attribute :in_progress
  attribute :match_time, key: :minutes_played, if: :in_progress  
  attribute :pre_match
  attribute :has_commentary

  def fixture_id
    object.id
  end

  def fixture_season
    object.season # Remember to check for leagues without seasons e.g friendly
  end

  def fixture_league
    object.season.league
  end

  def played?
    object.played?
  end

  def home_team
    {
      id: object.home_team.id, 
      name: object.home_team.name,
      goals_for:  object.home_goals_for,
      points: played? || !object.commentary? ? object.full_match_results[:home_team][:points] : nil,
      coach: object.home_team&.coach&.id
    }
  end

  def away_team
    {
      id: object.away_team.id, 
      name: object.away_team.name,
      goals_for: object.away_goals_for,
      points: played? || !object.commentary? ? object.full_match_results[:away_team][:points] : nil,
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

  def postponed
    object.postponed
  end

  def submit_results
    object.submit_results
  end

  def in_progress
    object.in_progress
  end

  def pre_match
    object.pre_match
  end

  def match_time
    object.match_time
  end

  def has_commentary
    !object.commentary?
  end
end
