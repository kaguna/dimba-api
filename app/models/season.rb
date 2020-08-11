class Season < ApplicationRecord
  validates :name, presence: true, allow_blank: false

  validates_uniqueness_of :name

  has_many :fixtures
  belongs_to :league
  
  scope :current, -> {where(current: true)}
end
