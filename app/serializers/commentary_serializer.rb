class CommentarySerializer < ActiveModel::Serializer
  attributes :id, :description, :commentary_time

  belongs_to :team
  belongs_to :player
  belongs_to :event

  # def commentary
  #   {
  #     id: object.id,
  #     event: event,
  #     description: object.description,
  #     commentary_time: object.commentary_time,
  #     team: team,
  #     player: player
  #   }
  # end

  def event
    {
      id: object.event.id, 
      name: object.event.name 
    }
  end

  def team
    {
      id: object.team.id, 
      name: object.team.name
    }
  end

  def player
    {
      id: object.player&.id, 
      name: player_full_name
    }
  end

  def player_full_name
    object.player&.nick_name # eventually it will be unique.
  end
end
