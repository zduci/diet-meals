class FoodConnection < ActiveRecord::Base
  attr_accessible :parent_food, :child_food
  belongs_to :parent_food, :class_name => 'Food'
  belongs_to :child_food, :class_name => 'Food'

  validates :parent_food_id, :presence => true, :uniqueness => { :scope => :child_food_id }
  validates :child_food_id, :presence => true

  def self.connect(parent, child)
    return if find_by_parent_food_id_and_child_food_id(parent, child)
    create!(:parent_food => parent, :child_food => child)
  end
end
