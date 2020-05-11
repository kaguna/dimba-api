class Result < Commentary
  include MatchResults
  include Standing



  scope :league_matches, -> (league_id, season_id) do
    Fixture.where(league_id: league_id, season_id: season_id).where("match_day < ?", Date.today)
  end 
  attr_accessor :lsm
  # scope :goals, -> { where(event_id: 1) }

  def self.league_season_matches_results(league_id, season_id)
    @lsm = league_matches(league_id, season_id).map do |match|  
        self.full_match_results(match&.id)
    end

    {matches: @lsm.length, league_season_matches: @lsm}
  end

  def self.full_match_results(match_id)
    MatchResults.get_match_results(match_id)
  end

  def self.standing(league_id, season_id)
    ls_matches = self.league_season_matches_results(league_id, season_id)[:league_season_matches]
    standing ||= Standing.league_season_standings(@lsm.nil? ? ls_matches : @lsm)
    {
      teams: standing.length,
      standing: standing
    }.to_json
  end

  def self.player_stats(league_id, season_id)
    self.base_class
        .eager_load(:fixture,:player, :team)
        .goals
        .where(fixtures: {league_id: league_id, season_id: season_id})
        .group(:player_id, :team_id)
        .count(:id)
  end
end
