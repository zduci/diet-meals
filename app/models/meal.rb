class Meal < ActiveRecord::Base
  attr_accessible :duration, :instructions, :ingredients, :name, :ingredients_attributes
  has_many :ingredients, :include => [:food, :unit_of_measurement], :dependent => :destroy
  has_many :foods, :through => :ingredients
  has_many :diet_classifications
  has_many :diets, :through => :diet_classifications

  validates :instructions, :presence => true
  validates :name, :presence => true
  validates :duration, :numericality => {:greater_than_or_equal_to => 1}

  accepts_nested_attributes_for :ingredients

  def self.create_meal(name, instructions, duration, *ingredients)
    create!(:name => name, 
            :instructions => instructions, 
            :duration => duration,
            :ingredients => ingredients)
  end

  def self.new_meal
    Meal.new do |meal|
      2.times { meal.ingredients.build(:food => Food.new) }
    end
  end
end
