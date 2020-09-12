class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :title, :current_season

  def current_season
    object.seasons.current.first
  end
end
