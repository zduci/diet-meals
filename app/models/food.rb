class Food < ActiveRecord::Base
  attr_accessible :name

  has_many :parent_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :parent_food_id
  has_many :parent_foods, :through => :parent_connections

  has_many :child_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :child_food_id
  has_many :child_foods, :through => :child_connections
end
