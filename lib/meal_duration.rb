class MealDuration
  def self.to_minutes(hours, minutes)
    hours.to_i * 60 + minutes.to_i
  end
end
