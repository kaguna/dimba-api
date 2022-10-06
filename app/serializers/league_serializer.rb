class LeagueSerializer < ActiveModel::Serializer
  attributes :id, :title, :official, :current_season, :friendly, :has_played_matches

  def title
    object.title.titleize
  end
  
  def current_season
    object.seasons.current.first
  end

  def has_played_matches
    object.seasons.current.first.fixtures.map(&:played).include?(true)
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
