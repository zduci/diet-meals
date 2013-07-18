class Diet < ActiveRecord::Base
  attr_accessible :name, :exclusive

  has_many :allowed_diet_food_connections, 
           :conditions => { :allowed => true }, 
           :class_name => DietFoodConnection
  has_many :allowed_foods, 
           :through => :allowed_diet_food_connections,
           :source => :food,
           :dependent => :destroy

  has_many :forbidden_diet_food_connections, 
           :conditions => { :allowed => false }, 
           :class_name => DietFoodConnection
  has_many :forbidden_foods, 
           :through => :forbidden_diet_food_connections,
           :source => :food,
           :dependent => :destroy

  has_many :meal_diet_classifications
  has_many :meals, :through => :meal_diet_classifications

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :exclusive, :inclusion => {:in => [true, false]}

  def inclusive?
    !exclusive
  end

  def self.create_inclusive(name)
    create!(:name => name, :exclusive => false)
  end

  def self.create_exclusive(name)
    create!(:name => name, :exclusive => true)
  end

  def has_allowed_foods?
    allowed_foods.present?
  end

  def self.popular
    Diet.all(:limit => 3)
  end

  def popular_classifications
    meal_diet_classifications.order('stars_count DESC').limit(5)
  end
end
