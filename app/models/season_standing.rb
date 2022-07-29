class SeasonStanding < ApplicationRecord
  has_one :season

  def self.archived_season(season_id:)
    season = find_by(season_id: season_id)
    season_standing = season.present? ? season.standing : {teams: 0, standing: []}.to_json
    JSON.parse(season_standing)
  end
end
