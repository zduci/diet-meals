class SelectOptions
  DEFAULT_HOURS = 0
  DEFAULT_MINUTES = 10

  def self.pairs(start=0, to_end)
    (start..to_end).map { |i| [i, i] }
  end

  HOURS = pairs(12)
  MINUTES = pairs(59)
  QUANTITIES = pairs(1, 30)
end
