class Ingredient < ActiveRecord::Base
  belongs_to :food
  belongs_to :unit_of_measurement
  belongs_to :meal

  validates :food_id, :presence => true
  validates :quantity, :presence => true, :numericality => {:greater_than_or_equal_to => 1}

  def self.create_ingredient(meal, food, quantity, unit_of_measurement=nil)
    create!(:meal => meal, :food => food, :unit_of_measurement => unit_of_measurement, :quantity => quantity)
  end

  def unit_of_measurement
    super || UnitOfMeasurement::PIECE
  end
end
