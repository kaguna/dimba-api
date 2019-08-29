class CommentarySerializer < ActiveModel::Serializer
  attributes :id, :event_id, :description, :commentary_time,
              :team_id, :player_id
  
  belongs_to :fixture
  belongs_to :event
  belongs_to :player
  belongs_to :team
end
