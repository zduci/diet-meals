class AllowedFoodConnection < ActiveRecord::Base
  attr_accessible :diet_id, :food_id

  belongs_to :diet
  belongs_to :food

  validates :diet_id, :presence => true, :uniqueness => {:scope => :food_id }
  validates :food_id, :presence => true
end
