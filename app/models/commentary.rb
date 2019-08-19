class Commentary < ApplicationRecord
  belongs_to :fixture
  belongs_to :team, optional: :true
end
