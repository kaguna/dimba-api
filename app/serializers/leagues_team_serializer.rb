class LeaguesTeamSerializer < ActiveModel::Serializer
  attributes :id, :team

  def team
  {
    id: object.team.id,
    name: object.team.name.to_s.titleize
  }
  end
end
