class Role < ApplicationRecord
  validates :name,
            presence: true, allow_blank: false

  has_many :users
end
