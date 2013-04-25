class Ingredient < ActiveRecord::Base
  attr_accessible :quantity, :food, :unit_of_measurement
  belongs_to :food
  belongs_to :unit_of_measurement
end
