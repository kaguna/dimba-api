class Event < ApplicationRecord
  validates :name, presence: true

  has_many :commentaries
end
