class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :title, :official, :current_season

  def current_season
    object.seasons.current.first
  end

  def official
    {
      id: object&.official&.id,
      username: object&.official&.username
    }
  end
end
