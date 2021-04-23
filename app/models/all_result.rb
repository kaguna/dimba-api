class AllResult < Commentary
  include MatchResults
  include Standing

  attr_accessor :lsm

  def self.league_season_matches_results(league_id)
    self.get_league_current_season(league_id).nil? ? @lsm = [] :
    @lsm = self.get_league_current_season(league_id).fixtures.where(id: played_match_ids).map do |match| 
      self.full_match_results(match&.id)
    end

    {matches: @lsm.length, league_season_matches: @lsm}
  end

  def self.full_match_results(match_id)
    MatchResults.get_match_results(match_id)
  end

  def self.standings(league_id)
    ls_matches = self.league_season_matches_results(league_id)[:league_season_matches]
    standing ||= Standing.league_season_standings(@lsm.nil? ? ls_matches : @lsm)
    {
      teams: standing.length,
      standing: standing
    }.to_json
  end

  def self.player_stats(league_id)
    # TODO: A very ugly query and response. Refactor later
    includes(:player, :team, fixture: [{league: :seasons}])
    .where(leagues: {id: league_id}, seasons: {id: self.get_league_current_season(league_id).id})
    .where.not(players: {id: nil}) # check later for: .where.not(players: {id: [nil, ""]})
    .goals
    .order(count: :desc)
    .group("players.id", :nick_name, "teams.id", "teams.name")
    .count(:id)
    .to_a
  end

  def self.all_incoming_matches
    # lims: Leagues incoming matches
    Season.includes(:league, :fixtures)
    .where(current: true)
    .where("Date(fixtures.match_day) >= ? AND Date(fixtures.match_day) < ?", 130.minutes.ago, (Date.today + 15.days))
    .order("fixtures.match_day ASC")
    .group(:id, "fixtures.id, leagues.id")
  end

  private

  def self.get_league_current_season(league_id)
    League.find(league_id).seasons.current.first
  end
end
