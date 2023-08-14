class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location, :nickname

  belongs_to :coach, serializer: UserSerializer

  def name
    object.name.titleize
  end
end
