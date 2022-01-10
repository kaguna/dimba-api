class Player < ApplicationRecord
  belongs_to :team
  has_many :fixture_squad
  has_many :fixtures, through: :fixture_squad
  has_many :commentaries
  has_many :player_inside, class_name: "Commentary", foreign_key: "player_in"

  validates :nick_name,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: false

  validates :id_number,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: true

  validates :phone_number,
            uniqueness: { case_sensitive: false },
            presence: true, allow_blank: true

  validates :first_name, presence: true
  validates :second_name, presence: true

end
