# frozen_string_literal: true

class SeasonStanding < ApplicationRecord
  has_one :season

  def self.archived_season(season_id:, tab:)
    tab ==='table' ? archived_standing(season_id: season_id) : archived_scorers(season_id: season_id)
  end

  private

  def self.archived_standing(season_id:)
    season = self.get_season(season_id: season_id)
    season_standing = season.present? ? season.standing : { teams: 0, standing: [] }.to_json
    JSON.parse(season_standing)
  end

  def self.archived_scorers(season_id:)
    season = self.get_season(season_id: season_id)
    season_scorers = season.present? && !season.scorers.nil? ? season.scorers : { scorers: [] }.to_json
    JSON.parse(season_scorers)
  end

  def self.get_season(season_id:)
    find_by(season_id: season_id)
  end
end
