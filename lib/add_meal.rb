class AddMeal
  def self.add(name, instructions, duration, *ingredients)
    Meal.create_meal(name, instructions, duration)
  end
end
