class AddMeal
  def self.from_params(meal_params)
    meal = Meal.new(add_duration(meal_params))
    create_classifications(meal) if  meal.save
    meal
  end

  private
  def self.add_duration(meal_params)
    meal_params[:duration] = MealDuration.to_minutes(meal_params[:duration_hours], meal_params[:duration_minutes])
    meal_params.except(:duration_minutes, :duration_hours)
  end

  def self.create_classifications(meal)
    MealClassifier.classify(meal).each do |diet|
      DietClassification.create_classification(meal, diet)
    end
  end
end
