class SeasonStanding < ApplicationRecord
  has_one :season

  def self.archived_season(season_id:)
    JSON.parse(find_by(season_id: season_id).standing)
  end
end
