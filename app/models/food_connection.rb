class FoodConnection < ActiveRecord::Base
  attr_accessible :parent_food, :child_food
  belongs_to :parent_food, :class_name => 'Food'
  belongs_to :child_food, :class_name => 'Food'

  validates :parent_food_id, :presence => true
  validates :child_food_id, :presence => true
end
