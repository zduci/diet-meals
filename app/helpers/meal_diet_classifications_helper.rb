module MealDietClassificationsHelper
  def link_to_stars(meal_diet_classification, current_user)
    star = meal_diet_classification.find_star(current_user)
    return link_to 'Unstar', star, :remote => true, :method => :delete, :id => "unstar_#{meal_diet_classification.id}"
  rescue ActiveRecord::RecordNotFound => e
    return link_to 'Star', stars_path(:meal_diet_classification_id => meal_diet_classification.id), :remote => true, :method => :post, :id => "star_#{meal_diet_classification.id}"
  end
end
