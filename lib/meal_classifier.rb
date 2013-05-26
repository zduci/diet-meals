require 'food_graph'

class MealClassifier
  def self.classify(meal)
    Diet.all.select { |diet| compatible?(diet, meal) }
  end
   
  def self.compatible?(diet, meal)
    if diet.exclusive
      compatible_for_exclusive(diet, meal)
    else
      compatible_for_inclusive(diet, meal)
    end
  end

  private

  def self.compatible_for_exclusive(diet, meal)
    if diet.has_allowed_foods?
      allowed_meal_foods(diet, meal) == meal.foods
    else
      false
    end
  end

  def self.compatible_for_inclusive(diet, meal)
    forbidden_meal_foods(diet, meal).empty?
  end

  private

  def self.allowed_meal_foods(diet, meal)
    ((FoodGraph.including_descendants(diet.allowed_foods) & meal.foods) - diet.forbidden_foods).sort
  end

  def self.forbidden_meal_foods(diet, meal)
    (diet.forbidden_foods & FoodGraph.including_ancestors(meal.foods)) - FoodGraph.including_ancestors(diet.allowed_foods)
  end

end
