class AddMeal
  def self.from_params(meal_params, user)
    meal = Meal.new(add_duration_and_user(meal_params, user))
    create_classifications(meal) if  meal.save
    meal
  end

  private
  def self.add_duration_and_user(meal_params, user)
    add_user(add_duration(meal_params), user)
  end

  def self.add_user(meal_params, user)
    meal_params[:user_id] = user.id
    meal_params
  end

  def self.add_duration(meal_params)
    meal_params[:duration] = MealDuration.to_minutes(meal_params[:duration_hours], meal_params[:duration_minutes])
    meal_params.except(:duration_minutes, :duration_hours)
  end

  def self.create_classifications(meal)
    MealClassifier.classify(meal).each do |diet|
      MealDietClassification.create_classification(meal, diet)
    end
  end
end
