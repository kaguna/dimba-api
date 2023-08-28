module FavouriteConcern
  def favourited?(category:, category_id:, user:)
    user&.favourites.where(category: category).pluck(:category_id).include? category_id
  end
end