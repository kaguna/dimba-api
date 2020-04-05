class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location, :nickname
end
