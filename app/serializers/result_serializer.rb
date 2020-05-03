class ResultSerializer < ActiveModel::Serializer
    attributes :player, :team

    belongs_to :player
    belongs_to :team
    belongs_to :fixture
end