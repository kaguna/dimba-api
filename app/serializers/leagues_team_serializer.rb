class LeaguesTeamSerializer < ActiveModel::Serializer
  attributes :id, :team

  def team
  {
    id: object.team.id,
    name: object.team.name
  }
  end
end
