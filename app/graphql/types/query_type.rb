Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :allTeams, !types[Types::TeamType] do
    resolve ->(obj, args, ctx) {
      Team.all
    }
  end

  field :oneTeam, !types[Types::TeamType] do
    argument :id, types.ID
    resolve ->(obj, args, ctx) {
      if  args[:id]
        team = Team.where(id: args[:id])
        if team.empty?
          GraphQL::ExecutionError.new("Team does not exist")
        else
          team
        end

      else
        GraphQL::ExecutionError.new("Team not selected")
      end
    }
  end
end
