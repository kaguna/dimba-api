class TeamSerializer < ActiveModel::Serializer
  include FavouriteConcern

  attributes :id, :name, :description, :location, :nickname
  attribute :favourited, if: -> { current_user.present? }

  belongs_to :coach, serializer: UserSerializer

  def name
    object.name.titleize
  end

  def favourited
    favourited?(category: 'team', category_id: object.id, user: current_user)
  end

  def current_user
    scope[:current_user] || nil
  end

  def detailed?
    scope[:show] === "details"
  end
end
