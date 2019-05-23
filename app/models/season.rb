class Season < ApplicationRecord
  validates :name,
            presence: true,
            allow_blank: false

  validates_uniqueness_of :name

  has_many :fixtures
<<<<<<< HEAD
  has_many :seasons
=======
>>>>>>> Creates seasons table. (#50)
end
