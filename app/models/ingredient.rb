class Ingredient < ActiveRecord::Base
  attr_accessible :quantity, :food, :unit_of_measurement, :recipe
  belongs_to :food
  belongs_to :unit_of_measurement
  belongs_to :recipe

  validates :recipe_id, :presence => true
  validates :unit_of_measurement_id, :presence => true
  validates :food_id, :presence => true
  validates :quantity, :presence => true
end
