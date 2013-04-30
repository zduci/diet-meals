[["kilogram", "kg"],
 ["gram", "g"],
 ["pound", "lb"],
 ["ounce", "oz"]].each do |unit_of_measurement|
  UnitOfMeasurement.find_or_create_by_name_and_short_name(unit_of_measurement[0],
                                                          unit_of_measurement[1])
end

sugar = Food.create_by_name(:sugar)
fruit = Food.create_by_name(:fruit)
tomato = Food.create_by_name(:tomato)
apple = Food.create_by_name(:apple)
citrus = Food.create_by_name(:citrus)
lemon = Food.create_by_name(:lemon)
vitamins = Food.create_by_name(:vitamin)
