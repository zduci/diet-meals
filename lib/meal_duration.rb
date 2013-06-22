class MealDuration
  def self.hours
    pairs(12)
  end

  def self.minutes
    pairs(59)
  end

  def self.pairs(limit)
    (0..limit).map { |i| [i, i] }
  end

  def self.to_minutes(hours, minutes)
    hours.to_i * 60 + minutes.to_i
  end
end
