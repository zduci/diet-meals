class AddMeal
  def self.from_params(meal_params)
    add(meal_params[:name], 
        meal_params[:instructions], 
        MealDuration.to_minutes(meal_params[:duration_hours], meal_params[:duration_minutes]),
        *meal_params[:ingredients_attributes].values)
  end

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
    food = Food.find(ingredient.fetch(:food).fetch(:id))
    quantity = ingredient[:quantity]
    unit_of_measurement_id = ingredient.fetch(:unit_of_measurement).fetch(:id)
    unit_of_measurement = UnitOfMeasurement.find(unit_of_measurement_id)
    Ingredient.create_ingredient(meal, 
                                 food,
                                 quantity,
                                 unit_of_measurement)
  end

  def self.create_classifications(meal)
    MealClassifier.classify(meal).each do |diet|
      DietClassification.create_classification(meal, diet)
    end
  end
end
