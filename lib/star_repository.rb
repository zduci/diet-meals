class StarRepository
  def self.add(classification_id, user)
    if Star.create_star(classification_id, user)
      MealDietClassification.stars_count(classification_id)
    else 
      false
    end
  end

  def self.delete(classification_id, user)
    if Star.delete_star(classification_id, user)
      MealDietClassification.stars_count(classification_id)
    else 
      false
    end
  end
end
