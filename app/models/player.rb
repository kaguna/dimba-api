class Player < ApplicationRecord
  validates :id_number, presence: true
  validates :first_name, presence: true
  validates :second_name, presence: true
  belongs_to :team
  belongs_to :fixture_squad
end
