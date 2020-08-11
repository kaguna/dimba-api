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

  scope :not_played, -> {  where("match_day > ?", Date.today) }
  scope :current_season, -> (league_id) { Season.includes(:league).where(leagues: {id: league_id}, current: true).first&.id}
  # Fix this later. Ugly!!

  def self.league_fixtures(league_id:)
    lsf ||= not_played.where(league_id: league_id, season_id: current_season(league_id: league_id) ).order(match_day: :ASC)
    {count: lsf.length, fixtures: lsf.map{|fixture| FixtureSerializer.new(fixture)}}
  end
end
