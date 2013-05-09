class Diet < ActiveRecord::Base
  attr_accessible :name

  has_many :allowed_food_connections
  has_many :allowed_foods, 
           :through => :allowed_food_connections,
           :source => :food
  has_many :forbidden_food_connections
  has_many :forbidden_foods, 
           :through => :forbidden_food_connections,
           :source => :food
end
