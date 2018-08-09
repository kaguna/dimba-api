class Player < ApplicationRecord
  validates :id_number, presence: true
  validates :first_name, presence: true
  validates :second_name, presence: true

  has_many :events
end
