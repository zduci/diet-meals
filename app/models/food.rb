class Food < ActiveRecord::Base
  attr_accessible :name

  has_many :parent_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :child_food_id,
           :dependent => :destroy
  has_many :parent_foods, :through => :parent_connections, :include => [:parent_foods]

  has_many :child_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :parent_food_id,
           :dependent => :destroy
  has_many :child_foods, :through => :child_connections, :include => [:child_foods]

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
end
