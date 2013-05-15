class Recipe < ActiveRecord::Base
  attr_accessible :duration, :instructions, :ingredients, :name
  has_many :ingredients, :include => [:food, :unit_of_measurement]
  has_many :foods, :through => :ingredients
end
