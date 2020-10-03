class TeamSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :location, :nickname, :coach_id
end
