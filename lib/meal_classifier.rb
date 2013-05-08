class MealClassifier
  def self.classify(meal)
    Diet.all.select { |diet| !diet.restrictive }
  end
end
