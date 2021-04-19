class TeamSeasonLeagueGamesQuery < BaseQuery

  attr_reader :relation, :team_id, :played

  def initialize(relation = Season.includes(:league, :fixtures))
    @relation = relation
  end

  def call(column, team_id, played)
    h = {}
    h.send('[]=', column, team_id).to_sym
    relation
    .where(fixtures: h)
    .where(fixtures: {played: played})
    .order("fixtures.match_day ASC")
    .group(:id, "leagues.id", "fixtures.id")
  end
end
