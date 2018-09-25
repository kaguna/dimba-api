Types::TeamType = GraphQL::ObjectType.define do
  name "Team"
  field :id, !types.ID
  field :name, !types.String
  field :description, !types.String
  field :location, !types.String
  field :nickname, !types.String
end
