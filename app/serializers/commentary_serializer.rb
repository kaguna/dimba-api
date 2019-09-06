class CommentarySerializer < ActiveModel::Serializer
  attributes :commentary
  
  belongs_to :fixture
  belongs_to :event
  belongs_to :player
  belongs_to :team

  def commentary
    {
      id: self.object.id,
      event: [self.object.event.id, self.object.event.name],
      description: self.object.description,
      commentary_time: self.object.commentary_time,
      team: self.object.team.name,
      player: self.object.player.nick_name
    }
  end
end
