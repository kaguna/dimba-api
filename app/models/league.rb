class League < ApplicationRecord
  has_many :fixtures, dependent: :destroy
  has_many :leagues_teams, dependent: :destroy
  has_many :teams, through: :leagues_teams
  has_many :leagues_sponsors, dependent: :destroy
  has_many :sponsors, through: :leagues_sponsors
  has_many :seasons
  belongs_to :official, class_name: "User", foreign_key: "official_id"

  validates :title, uniqueness: { case_sensitive: false}

  def friendly?
    title.to_s.downcase.in? ["friendly", "friendlies", "club friendlies"]
  end
end
