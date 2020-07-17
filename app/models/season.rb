class Season < ApplicationRecord
  has_many :fixtures
  belongs_to :league
  validates :name,
            presence: true,
            allow_blank: false

  validates_uniqueness_of :name

  scope :current, -> {where(current: true)}
end
