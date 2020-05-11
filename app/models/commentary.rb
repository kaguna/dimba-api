class Commentary < ApplicationRecord
  

  belongs_to :fixture
  belongs_to :team, optional: :true
  belongs_to :event
  belongs_to :player, optional: :true

  scope :commentaries, -> (match_id) { where(fixture_id: match_id) }
  scope :goals, -> { where(event_id: 1) }
  # scope :played, -> { Fixture.includes(:commentaries) }

  def self.match_commentaries(match_id)
    commentaries ||= commentaries(match_id)
    { 
      count: commentaries.length, 
      commentaries: commentaries.map{|commentary| CommentarySerializer.new(commentary)}
    }
  end
end
