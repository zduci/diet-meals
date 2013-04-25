class Ingredient < ActiveRecord::Base
  attr_accessible :food_id, :quantity, :unit_of_measurement_id
end
