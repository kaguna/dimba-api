class Season < ApplicationRecord
  validates :name,
            presence: true,
            allow_blank: false

  validates_uniqueness_of :name

  has_many :fixtures
  has_many :seasons
end
