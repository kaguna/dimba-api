class FixtureSerializer < ActiveModel::Serializer
  ACTUALFULLTIME=90.freeze
  EXTENDEDFULLTIME=130.freeze

  attributes :fixture_id, :home_team, :away_team, :match_day, :center_referee, :right_referee, :left_referee, :played
  attribute :postponed
  attribute :submit_results
  attribute :in_progress
  attribute :match_time, key: :minutes_played, if: :in_progress  
  attribute :pre_match

  def fixture_id
    object.id
  end

  def full_match_results
    object&.full_match_results(object.id)
  end

  def played?
    object.played?
  end

  def home_goals_for
    if played? then object.result.home_goals
    elsif !full_match_results.nil? then full_match_results[:home_team][:goals_for]
    else nil
    end
  end

  def away_goals_for
    if played? then object.result.away_goals
    elsif !full_match_results.nil? then full_match_results[:away_team][:goals_for]
    else nil
    end
  end

  def home_team
    {
      id: object.home_team.id, 
      name: object.home_team.name,
      goals_for:  home_goals_for,
      points: played? || !commentary? ? full_match_results[:home_team][:points] : nil,
      coach: object.home_team&.coach&.id
    }
  end

  def away_team
    {
      id: object.away_team.id, 
      name: object.away_team.name,
      goals_for: away_goals_for,
      points: played? || !commentary? ? full_match_results[:away_team][:points] : nil,
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

  def commentary?
    object.match_commentaries.empty?
  end

  def postponed
    !played? && commentary? && match_time > EXTENDEDFULLTIME
  end

  def submit_results
    !played? && !commentary? && extra_time?
  end


  def in_progress
    !played? && match_time < EXTENDEDFULLTIME && match_time > 0
  end

  def pre_match
    !played? && commentary? && match_time < 0
  end

  def match_time
    ((Time.now - object&.match_day)/60).round
  end

  def extra_time?
    match_time > ACTUALFULLTIME && match_time < EXTENDEDFULLTIME
  end
end
