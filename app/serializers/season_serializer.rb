class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :name, :current

  belongs_to :league
  has_many :fixtures
end
