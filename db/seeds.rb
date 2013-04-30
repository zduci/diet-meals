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

def create_connection(parent, child)
  FoodConnection.create(:parent_food => parent, :child_food => child)
end

create_connection(vitamins, fruit)
create_connection(fruit, tomato)
create_connection(fruit, apple)
create_connection(fruit, citrus)
create_connection(citrus, lemon)
create_connection(citrus, orange)
create_connection(sugar, orange)
create_connection(fruit, apple)
create_connection(sugar, apple)
