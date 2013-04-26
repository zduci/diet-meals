[["kilogram", "kg"],
 ["gram", "g"],
 ["pound", "lb"],
 ["ounce", "oz"]].each do |unit_of_measurement|
  UnitOfMeasurement.find_or_create_by_name_and_short_name(unit_of_measurement[0],
                                                          unit_of_measurement[1])
end

