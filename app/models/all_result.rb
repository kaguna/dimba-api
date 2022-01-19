class AllResult < Commentary
  include MatchResults
  include Standing

  attr_accessor :lsm

  def self.league_season_matches_results(league_id, season_id)
    self.league_current_season_id(league_id).nil? && !season_id.present? ? @lsm = [] :
    @lsm = Season.find(season_id.present? ? season_id : self.league_current_season_id(league_id)).fixtures.where(id: played_match_ids).map do |match| 
      self.full_match_results(match&.id)
    end

    {matches: @lsm.length, league_season_matches: @lsm}
  end

  def self.full_match_results(match_id)
    MatchResults.get_match_results(match_id)
  end

  def self.standings(league_id, season_id)
    ls_matches = self.league_season_matches_results(league_id, season_id)[:league_season_matches]
    standing ||= Standing.league_season_standings(ls_matches || @lsm)
    {
      teams: standing.length,
      standing: standing
    }.to_json
  end

  def self.player_stats(league_id)
    # TODO: Make this an ActiveRecord Query
    ActiveRecord::Base.connection.execute(
    "SELECT COUNT(DISTINCT commentaries.id) AS goals,
      COUNT(DISTINCT fixture_squads.id) AS appearances,
      players.id AS player_id, nick_name AS nick_name, teams.id AS team_id, teams.name AS team_name 
    FROM commentaries 
    LEFT OUTER JOIN players ON players.id = commentaries.player_id 
    LEFT OUTER JOIN fixture_squads ON fixture_squads.player_id = players.id
    LEFT OUTER JOIN teams ON teams.id = commentaries.team_id 
    LEFT OUTER JOIN fixtures ON fixtures.id = commentaries.fixture_id 
    LEFT OUTER JOIN leagues ON leagues.id = fixtures.league_id 
    LEFT OUTER JOIN seasons ON seasons.league_id = leagues.id 
    WHERE leagues.id = #{league_id} AND seasons.id = #{self.league_current_season_id(league_id)} AND players.id IS NOT NULL AND commentaries.event_id = 1 AND
    (fixture_squads.playing = true AND fixture_squads.starting = true OR fixture_squads.starting = false)
    GROUP BY players.id, nick_name, teams.id, teams.name ORDER BY goals DESC").as_json
  end

  def self.all_incoming_matches
    # lims: Leagues incoming matches
    Season.includes(:league, :fixtures)
    .where(current: true)
    .where("Date(fixtures.match_day) >= ? AND Date(fixtures.match_day) < ?", 130.minutes.ago, (Date.today + 2.days))
    .order("fixtures.match_day ASC")
    .group(:id, "fixtures.id, leagues.id")
  end

  private

  def self.league_current_season_id(league_id)
    League.find(league_id).seasons.current&.first&.id
  end
end
