class SelectOptions
  def self.hours
    pairs(12)
  end

  def self.minutes
    pairs(59)
  end

  def self.pairs(start=0, to_end)
    (start..to_end).map { |i| [i, i] }
  end
end
