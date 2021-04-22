class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location, :nickname

  belongs_to :coach, serializer: UserSerializer
end
