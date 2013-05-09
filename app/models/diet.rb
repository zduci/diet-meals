class Diet < ActiveRecord::Base
  attr_accessible :name

  has_many :allowed_foods
  has_many :allowed, 
           :through => :allowed_foods,
           :source => :food
  has_many :forbidden_food_connections
  has_many :forbidden_foods, 
           :through => :forbidden_food_connections,
           :source => :food
end
