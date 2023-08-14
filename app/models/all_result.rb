class AllResult < Commentary
  include MatchResults
  include Standing

  attr_accessor :lsm
  # Same method in Results Model. Refactor! This is for live matches and standing
  # Current season matches/live matches
  def self.league_season_matches_results(league_id, season_id)
    current_season_id = self.league_current_season_id(league_id)
    current_season_id.nil? && season_id.nil? ? @lsm = [] :
      @lsm = Season.find(season_id.present? ? season_id : current_season_id)
                    .fixtures.played.map { |match| self.full_match_results(match&.id) }

    { matches: @lsm.length, league_season_matches: @lsm }
  end

  def self.full_match_results(match_id)
    MatchResults.get_match_results(match_id)
  end

  def self.standings(league_id, season_id)
    return {teams: 0, standing: []}.to_json if self.league(league_id).friendly?
    ls_matches = self.league_season_matches_results(league_id, season_id)[:league_season_matches]
    standing ||= Standing.league_season_standings(ls_matches || @lsm)
    {
      teams: standing.length,
      standing: standing
    }.to_json
  end

  def self.player_stats(league_id, season_id)
    # TODO: Make this an ActiveRecord Query
    season_id = season_id ? season_id : self.league_current_season_id(league_id) ? self.league_current_season_id(league_id) : "NULL"
    ActiveRecord::Base.connection.execute(
    "SELECT COUNT(DISTINCT commentaries.id) AS goals,
      players.id AS player_id, nick_name AS nick_name, teams.id AS team_id, teams.name AS team_name 
    FROM commentaries 
    LEFT OUTER JOIN players ON players.id = commentaries.player_id
    LEFT OUTER JOIN teams ON teams.id = commentaries.team_id 
    LEFT OUTER JOIN fixtures ON fixtures.id = commentaries.fixture_id
    LEFT OUTER JOIN seasons ON seasons.id = fixtures.season_id
    LEFT OUTER JOIN leagues ON leagues.id = seasons.league_id 
    WHERE leagues.id = #{league_id} AND seasons.id = #{season_id} AND players.id IS NOT NULL AND commentaries.event_id = 1
    GROUP BY players.id, nick_name, teams.id, teams.name ORDER BY goals DESC").as_json
  end

  def self.all_incoming_matches(match_day)
    # lims: Leagues incoming matches
    Season.includes(:league, :fixtures)
    .where(current: true)
    .where("Date(fixtures.match_day) = ?", Date.parse(match_day, '%Y-%m-%d'))
    .order("fixtures.match_day ASC")
    .group(:id, "fixtures.id, leagues.id")
  end

  private

  def self.league_current_season_id(league_id)
    self.league(league_id).seasons.current&.first&.id
  end

  def self.league(league_id)
    League.find(league_id)
  end
end
