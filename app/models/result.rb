class Result < ApplicationRecord
  
  belongs_to :fixture

  validates_uniqueness_of :fixture_id, message: "results has already been updated!"

  # before_save :check_if_any_event
  after_save :mark_fixture_played!

  def self.league_season_matches_results(league_id, season_id, per_page, page)
    lsr = includes(fixture:[:season])
    .where(fixtures: {league_id: league_id}, seasons: {id: self.get_season(league_id, season_id)})
    .order("fixtures.match_day Desc")
    results = lsr.limit(per_page.to_i).offset(page.to_i)
    {count: lsr.length, results: results.map{|result| ResultSerializer.new(result)}}
  end

  private

  # def check_if_any_event
  #   raise "No events in this match!" unless Commentary.exists?(fixture_id: self.fixture_id)
  # end

  def mark_fixture_played!
    Fixture.where(id: self.fixture_id).update(played: true)
  end

  def points(home_goals, away_goals)
    if home_goals > away_goals then 3
    elsif home_goals == away_goals then 1
    else 0
    end
  end

  def self.get_season(league_id, season_id)
    # TODO: Refactor this, maybe in a service
    Season.find(season_id.present? ? season_id : self.league_current_season_id(league_id))
  end

  def self.league_current_season_id(league_id)
    # TODO: Refactor this, maybe in a service
    League.find(league_id).seasons.current&.first&.id
  end
end