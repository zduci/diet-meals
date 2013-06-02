class AddMeal
  def self.add(name, instructions, duration, *ingredients)
    meal = Meal.create_meal(name, instructions, duration)
    create_ingredients_for(meal, ingredients)
    meal
  end

  def self.create_ingredients_for(meal, ingredients)
    ingredients.each { |ingredient_attributes| create_ingredient_for(meal, ingredient_attributes) }
  end

  def self.create_ingredient_for(meal, ingredient)
    food = Food.find_by_name!(ingredient[:name])
    quantity = ingredient[:quantity]
    if ingredient.has_key?(:unit_of_measurement)
      Ingredient.create_ingredient(meal, 
                                   food,
                                   quantity,
                                   UnitOfMeasurement.find_by_short_name!(ingredient.fetch(:unit_of_measurement)))
    else 
      Ingredient.create_ingredient(meal, 
                                   food,
                                   quantity)
    end
  end
end
