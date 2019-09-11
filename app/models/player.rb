class Player < ApplicationRecord
  validates :id_number, presence: true
  validates :first_name, presence: true
  validates :second_name, presence: true
  belongs_to :team
  has_many :fixture_squad
  has_many :fixtures, through: :fixture_squad
  has_many :commentaries
end
