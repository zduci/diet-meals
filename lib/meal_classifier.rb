require 'food_graph'

class MealClassifier
  def self.classify(meal)
    Diet.all.select { |diet| compatible?(diet, meal) }
  end
   
  def self.compatible?(diet, meal)
    if diet.exclusive?
      compatible_for_exclusive(diet, meal)
    else
      compatible_for_inclusive(diet, meal)
    end
  end

  private

  def self.compatible_for_exclusive(diet, meal)
    if diet.has_allowed_foods?
      foods_from_meal_allowed_on_diet(diet, meal) == meal.foods
    else
      false
    end
  end

  def self.compatible_for_inclusive(diet, meal)
    foods_from_meal_forbidden_on_diet(diet, meal).empty?
  end

  private

  def self.foods_from_meal_allowed_on_diet(diet, meal)
    allowed_foods_with_descendendants(diet) & meal.foods - FoodGraph.including_descendants(diet.forbidden_foods)
  end

  def self.allowed_foods_with_descendendants(diet)
    FoodGraph.including_descendants(diet.allowed_foods)
  end

  def self.foods_from_meal_forbidden_on_diet(diet, meal)
    diet.forbidden_foods & foods_with_ancestors(meal) - FoodGraph.including_ancestors(diet.allowed_foods)
  end

  def self.foods_with_ancestors(meal)
    FoodGraph.including_ancestors(meal.foods)
  end
end
