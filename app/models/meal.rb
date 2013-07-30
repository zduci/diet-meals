class Meal < ActiveRecord::Base
  attr_accessible :duration, :instructions, :ingredients, :name, :ingredients_attributes, :user_id
  has_many :ingredients, :dependent => :destroy
  has_many :foods, :through => :ingredients
  has_many :meal_diet_classifications
  has_many :diets, :through => :meal_diet_classifications
  belongs_to :user

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

  def popular_classifications
    meal_diet_classifications.order('stars_count DESC').limit(5)
  end

  def author
    user || User::ANONYMOUS
  end
end
