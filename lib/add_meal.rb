class AddMeal
  def self.add(name, instructions, duration, *ingredients)
    meal = Meal.create_meal(name, instructions, duration)
    create_ingredients_for(meal, ingredients)
    create_classifications(meal)
    meal.reload
  end

  private
  def self.create_ingredients_for(meal, ingredients)
    ingredients.each { |ingredient_attributes| create_ingredient_for(meal, ingredient_attributes) }
  end

  def self.create_ingredient_for(meal, ingredient)
    food = Food.find_by_name!(ingredient.fetch(:food).fetch(:name))
    quantity = ingredient[:quantity]
    unit_of_measurement_short_name = ingredient.fetch(:unit_of_measurement).fetch(:short_name)
    if unit_of_measurement_short_name.present?
      unit_of_measurement = UnitOfMeasurement.find_by_short_name!(unit_of_measurement_short_name)
      Ingredient.create_ingredient(meal, 
                                   food,
                                   quantity,
                                   unit_of_measurement)
    else 
      Ingredient.create_ingredient(meal, 
                                   food,
                                   quantity)
    end
  end

  def self.create_classifications(meal)
    diets = MealClassifier.classify(meal)
    diets.each do |diet|
      DietClassification.create_classification(meal, diet)
    end
  end
end
