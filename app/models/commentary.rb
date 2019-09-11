class Commentary < ApplicationRecord
  belongs_to :fixture
  belongs_to :team, optional: :true
  belongs_to :event
  belongs_to :player, optional: :true
end
