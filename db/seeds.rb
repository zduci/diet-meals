require_relative '../lib/food_graph'

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

FoodConnection.connect(vitamins, fruit)
FoodConnection.connect(fruit, tomato)
FoodConnection.connect(fruit, apple)
FoodConnection.connect(fruit, citrus)
FoodConnection.connect(citrus, lemon)
FoodConnection.connect(citrus, orange)
FoodConnection.connect(sugar, orange)
FoodConnection.connect(fruit, apple)
FoodConnection.connect(sugar, apple)

Diet.create(:name => 'Slow Carb Diet', :exclusive => true).tap do |diet|
  diet.allowed_foods << [Food.find_or_create_by_name(:meat),
                         Food.find_or_create_by_name(:eggs),
                         Food.find_or_create_by_name(:vegetables),
                         Food.find_or_create_by_name(:legumes)]
end
            
