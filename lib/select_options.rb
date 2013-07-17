class SelectOptions
  def self.pairs(start=0, to_end)
    (start..to_end).map { |i| [i, i] }
  end

  HOURS = pairs(12)
  MINUTES = pairs(59)
  QUANTITIES = pairs(1, 30)
end
