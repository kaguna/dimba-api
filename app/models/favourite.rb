class Favourite < ApplicationRecord
  belongs_to :user

  enum category: { team: 0, match: 1, league: 2 }
  validates :user_id, uniqueness: { scope: [:category, :category_id], case_sensitive: true, message: 'can only favourite a category once' }
  validates_presence_of :category, :category_id, :user_id
end
