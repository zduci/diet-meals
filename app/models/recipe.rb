class Recipe < ActiveRecord::Base
  attr_accessible :duration, :instructions, :ingredients, :name
  has_many :ingredients, :include => [:food, :unit_of_measurement], :dependent => :destroy
  has_many :foods, :through => :ingredients

  validates :instructions, :presence => true
  validates :name, :presence => true
  validates :duration, :allow_blank => true, :numericality => {:greater_than_or_equal_to => 1}
end
