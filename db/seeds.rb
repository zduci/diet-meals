require_relative '../lib/food_graph'

[["kilogram", "kg"],
 ["gram", "g"],
 ["pound", "lb"],
 ["ounce", "oz"]].each do |unit_of_measurement|
  UnitOfMeasurement.find_or_create_by_name_and_short_name(unit_of_measurement[0],
                                                          unit_of_measurement[1])
end

sugar = Food.find_or_create_by(:name => :sugar)
fruit = Food.find_or_create_by(:name => :fruit)
tomato = Food.find_or_create_by(:name => :tomato)
apple = Food.find_or_create_by(:name => :apple)
citrus = Food.find_or_create_by(:name => :citrus)
lemon = Food.find_or_create_by(:name => :lemon)
vitamins = Food.find_or_create_by(:name => :vitamin)
orange = Food.find_or_create_by(:name => :orange)

FoodConnection.connect(vitamins, fruit)
FoodConnection.connect(fruit, tomato)
FoodConnection.connect(fruit, apple)
FoodConnection.connect(fruit, citrus)
FoodConnection.connect(citrus, lemon)
FoodConnection.connect(citrus, orange)
FoodConnection.connect(sugar, orange)
FoodConnection.connect(fruit, apple)
FoodConnection.connect(sugar, apple)

eggs = Food.find_or_create_by(:name => :eggs)
meat = Food.find_or_create_by(:name => :meat)
seafood = Food.find_or_create_by(:name => :seafood)
beans = Food.find_or_create_by(:name => :beans)
vegetables = Food.find_or_create_by(:name => :vegetables)
starches = Food.find_or_create_by(:name => :starches)
potatoes = Food.find_or_create_by(:name => :potatoes)
sweet_potatoes = Food.find_or_create_by(:name => :sweet_potatoes)
yams = Food.find_or_create_by(:name => :yams)
oil = Food.find_or_create_by(:name => :oil)
ghee = Food.find_or_create_by(:name => :ghee)
cottage_cheese = Food.find_or_create_by(:name => :cottage_cheese)
mustard = Food.find_or_create_by(:name => :mustard)
salsa = Food.find_or_create_by(:name => :salsa)
hot_sauce = Food.find_or_create_by(:name => :hot_sauce)
spices = Food.find_or_create_by(:name => :spices)
herbs = Food.find_or_create_by(:name => :herbs)

FoodConnection.connect(vegetables, starches)
FoodConnection.connect(starches, potatoes)
FoodConnection.connect(starches, sweet_potatoes)
FoodConnection.connect(starches, yams)

unless Diet.find_by_name('Slow Carb Diet') 
  Diet.create_exclusive('Slow Carb Diet').tap do |diet|
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
end
