class Result < Commentary
  include MatchResults
  include Standing

  scope :current_season, -> {Season.current.first&.id}
  attr_accessor :lsm

  scope :league_matches, -> (league_id) do
    Fixture.where(league_id: league_id, season_id: current_season).where("match_day < ?", Date.today)
  end 

  def self.league_season_matches_results(league_id)
    @lsm = league_matches(league_id).map do |match|  
        self.full_match_results(match&.id)
    end

    {matches: @lsm.length, league_season_matches: @lsm}
  end

  def self.full_match_results(match_id)
    MatchResults.get_match_results(match_id)
  end

  def self.standing(league_id)
    ls_matches = self.league_season_matches_results(league_id)[:league_season_matches]
    standing ||= Standing.league_season_standings(@lsm.nil? ? ls_matches : @lsm)
    {
      teams: standing.length,
      standing: standing
    }.to_json
  end

  def self.player_stats(league_id)
    # TODO: A very ugly query and response. Refactor later
    ts ||= Player.joins(commentaries: [{ fixture: [{league: :seasons}]}, :team])
    .where(commentaries: {event_id: 1}, leagues: {id: league_id}, seasons: {id: current_season})
    .group(:id, :nick_name, "teams.id", "teams.name")
    .order(count: :desc)
    .count(:id)
    .to_a
  end
end
