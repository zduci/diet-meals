require_relative '../lib/food_graph'
require_relative '../lib/food_graph_connection'

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

FoodGraphConnection.create(vitamins, fruit)
FoodGraphConnection.create(fruit, tomato)
FoodGraphConnection.create(fruit, apple)
FoodGraphConnection.create(fruit, citrus)
FoodGraphConnection.create(citrus, lemon)
FoodGraphConnection.create(citrus, orange)
FoodGraphConnection.create(sugar, orange)
FoodGraphConnection.create(fruit, apple)
FoodGraphConnection.create(sugar, apple)


Diet.create(:name => 'Slow Carb Diet').tap do |diet|
  diet.allowed << [Food.find_or_create_by_name(:meat),
                   Food.find_or_create_by_name(:eggs),
                   Food.find_or_create_by_name(:vegetables),
                   Food.find_or_create_by_name(:legumes)]
end
            
