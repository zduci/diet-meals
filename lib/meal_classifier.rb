class MealClassifier
  def self.classify(meal)
    Diet.all.select { |diet| compatible?(diet, meal) }
  end
   
  def self.compatible?(diet, meal)
    unless diet.restrictive
      (diet.forbidden_foods & meal.ingredients).empty?
    else
      false
    end
  end
end
