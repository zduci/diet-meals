class Recipe < ActiveRecord::Base
  attr_accessible :duration, :instructions, :ingredients, :name
  has_many :ingredients, :include => [:food, :unit_of_measurement], :dependent => :destroy
  has_many :foods, :through => :ingredients

  validates :instructions, :presence => true
  validates :name, :presence => true
end
