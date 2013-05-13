require 'food_graph'

class MealClassifier
  def self.classify(meal)
    Diet.all.select { |diet| compatible?(diet, meal) }
  end
   
  def self.compatible?(diet, meal)
    if diet.restrictive
      compatible_for_restrictive(diet, meal)
    else
      compatible_for_unrestrictive(diet, meal)
    end
  end

  private

  def self.compatible_for_restrictive(diet, meal)
    if diet.allowed_foods.empty?
      false
    else
      allowed_meal_ingredients(diet, meal) == meal.ingredients
    end
  end

  def self.compatible_for_unrestrictive(diet, meal)
    forbidden_meal_ingredients(diet, meal).empty?
  end

  private

  def self.allowed_meal_ingredients(diet, meal)
    ((including_descendants(diet.allowed_foods) & meal.ingredients) - diet.forbidden_foods).sort
  end

  def self.forbidden_meal_ingredients(diet, meal)
    (diet.forbidden_foods & including_ancestors(meal.ingredients)) - including_ancestors(diet.allowed_foods)
  end

  def self.including_ancestors(foods)
    including(:find_ancestors, foods)
  end

  def self.including_descendants(foods)
    including(:find_descendants, foods)
  end

  def self.including(method, foods)
    foods.inject(foods) do |result, food|
      result + FoodGraph.send(method, food)
    end
  end
end
