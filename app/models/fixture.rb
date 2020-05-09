class Fixture < ApplicationRecord
  validates :away_team_id, presence: true
  validates :home_team_id, presence: true
  
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
  has_many :commentaries, dependent: :destroy

  # scope :league_fixtures, -> (league_id:, season_id:) { where(league_id: league_id, season_id: season_id).order(match_day: :ASC) }
  
  scope :not_played, -> {  where("match_day > ?", Date.today) }

  def self.league_fixtures(league_id:, season_id:)
    lsf ||= where(league_id: league_id, season_id: season_id).order(match_day: :ASC).not_played
  end

  # class << self

  #   def league_matches_results(match)
  #     # match_commentaries(match_id).map do |match|
  #     match_stats(match)
  #     # end.compact.to_json
  #   end

  #   # def match_commentaries(match_id)
  #   #   @match_commentaries ||= self.eager_load(:commentaries, :home_team, :away_team).where(id:match_id )
  #   # end

  #   def played?
  #     self.commentaries.present?
  #   end

  #   def match_stats(match)
  #     commentaries = match.commentaries

  #     # Excludes all the matches which are yet to be played.
  #     # return unless commentaries.present?

  #     home_team = match.home_team
  #     away_team = match.away_team

  #     home_team_goals = match_team_goals(match_commentaries: commentaries,
  #                                         team: home_team)
  #     away_team_goals = match_team_goals(match_commentaries: commentaries,
  #                                         team: away_team)
  #     {
  #       fixture_id: fixture.id,
  #       home_team: team_stats(team: home_team,
  #                               goals_for: home_team_goals,
  #                               goals_against: away_team_goals),
  #       away_team: team_stats(team: away_team,
  #                             goals_for: away_team_goals,
  #                             goals_against: home_team_goals)
  #     }
  #   end

  #   def team_stats(team:, goals_for:, goals_against:)
  #     {
  #       team_id: team.id,
  #       team_name: team.name,
  #       goals_for: goals_for,
  #       goals_against: goals_against,
  #       points: calculate_match_points(goals_for: goals_for,
  #                                     goals_against: goals_against)
  #     }
  #   end

  #   def match_team_goals(match_commentaries:, team:)
  #       match_commentaries.where(event_id: 1, team: team).pluck(:event_id).sum
  #   end

  #   def calculate_match_points(goals_for:, goals_against:)
  #     if goals_for > goals_against then 3
  #     elsif goals_for == goals_against then 1
  #     else 0
  #     end
  #   end
  # end
end
