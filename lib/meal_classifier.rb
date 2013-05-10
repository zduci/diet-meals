class MealClassifier
  def self.classify(meal)
    Diet.all.select { |diet| compatible?(diet, meal) }
  end
   
  def self.compatible?(diet, meal)
    unless diet.restrictive
      (diet.forbidden_foods & meal.ingredients).empty?
    else
      if diet.allowed_foods.empty?
        false
      else
        (diet.allowed_foods & meal.ingredients).sort == meal.ingredients
      end
    end
  end
end
