class Sponsor < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :contacts
  has_many :leagues_sponsors
  has_many :leagues, through: :leagues_sponsors
end
