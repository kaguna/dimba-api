class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :title, :official, :current_season, :friendly

  def title
    object.title.titleize
  end
  
  def current_season
    object.seasons.current.first
  end

  def official
    {
      id: object&.official&.id,
      username: object&.official&.username.to_s.titleize
    }
  end

  def friendly
    object.friendly?
  end
end
