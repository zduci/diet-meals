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
      (including_children(diet.allowed_foods) & meal.ingredients).sort == meal.ingredients
    end
  end

  def self.compatible_for_unrestrictive(diet, meal)
    (diet.forbidden_foods & including_ancestors(meal.ingredients)).empty?
  end

  def self.including_ancestors(foods)
    foods.inject(foods) do |result, food|
      result + FoodGraph.find_ancestors(food)
    end
  end

  def self.including_children(foods)
    foods.inject(foods) do |result, element|
      result + element.child_foods
    end
  end
end
