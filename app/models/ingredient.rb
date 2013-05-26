class Ingredient < ActiveRecord::Base
  attr_accessible :quantity, :food, :unit_of_measurement, :recipe
  belongs_to :food
  belongs_to :unit_of_measurement
  belongs_to :recipe

  validates :recipe_id, :presence => true
  validates :unit_of_measurement_id, :presence => true
  validates :food_id, :presence => true
  validates :quantity, :presence => true, :numericality => {:greater_than_or_equal_to => 1}

  def self.create_ingredient(recipe, food, unit_of_measurement, quantity)
    create!(:recipe => recipe, :food => food, :unit_of_measurement => unit_of_measurement, :quantity => quantity)
  end
end
