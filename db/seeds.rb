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

eggs = Food.find_or_create_by_name(:eggs)
meat = Food.find_or_create_by_name(:meat)
seafood = Food.find_or_create_by_name(:seafood)
beans = Food.find_or_create_by_name(:beans)
vegetables = Food.find_or_create_by_name(:vegetables)
starches = Food.find_or_create_by_name(:starches)
potatoes = Food.find_or_create_by_name(:potatoes)
sweet_potatoes = Food.find_or_create_by_name(:sweet_potatoes)
yams = Food.find_or_create_by_name(:yams)
oil = Food.find_or_create_by_name(:oil)
ghee = Food.find_or_create_by_name(:ghee)
cottage_cheese = Food.find_or_create_by_name(:cottage_cheese)
mustard = Food.find_or_create_by_name(:mustard)
salsa = Food.find_or_create_by_name(:salsa)
hot_sauce = Food.find_or_create_by_name(:hot_sauce)
spices = Food.find_or_create_by_name(:spices)
herbs = Food.find_or_create_by_name(:herbs)

FoodConnection.connect(vegetables, starches)
FoodConnection.connect(starches, potatoes)
FoodConnection.connect(starches, sweet_potatoes)
FoodConnection.connect(starches, yams)

Diet.create!(:name => 'Slow Carb Diet', :exclusive => true).tap do |diet|
  diet.allowed_foods << [eggs,
                         meat,
                         seafood,
                         beans,
                         vegetables,
                         yams,
                         oil,
                         ghee,
                         cottage_cheese,
                         mustard,
                         salsa,
                         hot_sauce,
                         spices,
                         herbs]
  diet.forbidden_foods << [starches]
end
            
