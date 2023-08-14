class Fixture < ApplicationRecord
  include MatchResults
  # include AASM
  ACTUALFULLTIME=90.freeze
  EXTENDEDFULLTIME=130.freeze
  
  belongs_to :league
  belongs_to :season
  belongs_to :center_referee, class_name: "User", foreign_key: "center_referee_id", optional: true
  belongs_to :right_side_referee, class_name: "User", foreign_key: "right_side_referee_id", optional: true
  belongs_to :left_side_referee, class_name: "User", foreign_key: "left_side_referee_id", optional: true
  
  belongs_to :home_team, class_name: "Team", foreign_key: "home_team_id"
  belongs_to :away_team, class_name: "Team", foreign_key: "away_team_id"
  has_one :result, dependent: :destroy
  has_many :fixture_squad, dependent: :destroy
  has_many :players, through: :fixture_squad
  has_many :match_commentaries, -> { order('CAST(commentary_time as INT) desc') }, class_name: "Commentary", dependent: :destroy

  validates :away_team_id, presence: true
  validates :home_team_id, presence: true
  # validates_uniqueness_of :home_team_id, scope: [:away_team_id, :season_id, :league_id]
  # validates_uniqueness_of :away_team_id, scope: [:home_team_id, :season_id, :league_id]

  scope :not_played, -> {  where(played: false).order(match_day: :ASC) }
  scope :played, -> {  where(played: true).order(match_day: :ASC) }

  def full_match_results
    MatchResults.get_match_results(self.id)
  end

  def self.league_fixtures(league_id:, per_page:, page:)
    lsf ||= not_played.includes(:season).where(league_id: league_id, seasons: {current: true}).order(match_day: :ASC)
    l_season_fixtures = lsf.limit(per_page.to_i).offset(page.to_i)
    {count: lsf.length, fixtures: l_season_fixtures}
  end

  def self.h2h_team_matches(teams_ids, per_page, page)
    # TODO: check if secure from sql injection 
    cond = teams_ids.length == 2 ? "and" : "or"
    matches = played.where(
      "home_team_id IN (?) #{cond} away_team_id IN (?) ", teams_ids, teams_ids
    ).reorder(match_day: :desc)
    h2h_matches = matches.limit(per_page.to_i).offset(page.to_i)
    {count: matches.length, fixtures: h2h_matches.map{|fixture| FixtureSerializer.new(fixture)}}
  end

  def home_goals_for
    if played? then result.home_goals
    elsif !full_match_results.nil? then full_match_results[:home_team][:goals_for]
    else nil
    end
  end

  def away_goals_for
    if played? then result.away_goals
    elsif !full_match_results.nil? then full_match_results[:away_team][:goals_for]
    else nil
    end
  end

  def commentary?
    match_commentaries.empty?
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
    ((Time.now - self&.match_day)/60).round
  end

  def extra_time?
    match_time > ACTUALFULLTIME && match_time < EXTENDEDFULLTIME
  end
end
