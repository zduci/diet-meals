class FoodConnection < ActiveRecord::Base
  attr_accessible :child_food, :parent_food
end
