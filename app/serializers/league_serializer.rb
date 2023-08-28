class LeagueSerializer < ActiveModel::Serializer
  include FavouriteConcern

  attributes :id, :title, :friendly, :has_played_matches
  attribute :official, if: -> { detailed? }
  attribute :current_season, if: -> { detailed? }
  attribute :sponsors, if: -> { detailed? }
  attribute :favourited, if: -> { current_user.present? }

  def title
    object.title.titleize
  end
  
  def current_season
    object.seasons.current.first
  end

  def has_played_matches
    current_season.nil? ? false : current_season.fixtures.map(&:played).include?(true)
  end

  def league_sponsors
    object.sponsors
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

  def favourited
    favourited?(category: 'league', category_id: object.id, user: current_user)
  end

  def current_user
    scope[:current_user]
  end

  def detailed?
    scope[:show] === "details"
  end
end
