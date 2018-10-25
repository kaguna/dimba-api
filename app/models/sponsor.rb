class Sponsor < ApplicationRecord
  validates_presence_of :name,
                        :description,
                        :contacts
end
