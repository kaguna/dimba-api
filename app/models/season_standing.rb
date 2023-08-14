# frozen_string_literal: true

class SeasonStanding < ApplicationRecord
  has_one :season

  def self.archived_season(season_id:, tab:)
    if tab === 'table'
      archived_standing(season_id: season_id)
    else
      archived_scorers(season_id: season_id)
    end
  end
  class << self
    private

    def archived_standing(season_id:)
      season = get_season(season_id: season_id)
      season_standing = season.present? ? season.standing : { teams: 0, standing: [] }.to_json
      JSON.parse(season_standing)
    end

    def archived_scorers(season_id:)
      season = get_season(season_id: season_id)
      season_scorers = season.present? && !season.scorers.nil? ? season.scorers : { scorers: [] }.to_json
      JSON.parse(season_scorers)
    end

    def get_season(season_id:)
      find_by(season_id: season_id)
    end
  end
end
