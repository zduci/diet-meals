[["kilogram", "kg"],
 ["gram", "g"],
 ["pound", "lb"],
 ["ounce", "oz"]].each do |unit_of_measurement|
  UnitOfMeasurement.find_or_create_by_name_and_short_name(unit_of_measurement[0],
                                                          unit_of_measurement[1])
end

sugar = Food.find_or_create_by_name(:sugar)
fruit = Food.find_or_create_by_name(:fruit)
tomato = Food.find_or_create_by_name(:tomato)
apple = Food.find_or_create_by_name(:apple)
citrus = Food.find_or_create_by_name(:citrus)
lemon = Food.find_or_create_by_name(:lemon)
vitamins = Food.find_or_create_by_name(:vitamin)
orange = Food.find_or_create_by_name(:orange)

FoodGraph.connect(vitamins, fruit)
FoodGraph.connect(fruit, tomato)
FoodGraph.connect(fruit, apple)
FoodGraph.connect(fruit, citrus)
FoodGraph.connect(citrus, lemon)
FoodGraph.connect(citrus, orange)
FoodGraph.connect(sugar, orange)
FoodGraph.connect(fruit, apple)
FoodGraph.connect(sugar, apple)
