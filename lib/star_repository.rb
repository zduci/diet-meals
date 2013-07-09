class StarRepository
  def self.add(classification_id, user)
    if Star.create_star(classification_id, user)
      MealDietClassification.stars_count(classification_id)
    else 
      false
    end
  end
end
