class AllowedFoodConnection < ActiveRecord::Base
  attr_accessible :diet_id, :food_id

  belongs_to :diet
  belongs_to :food

  validates :diet, :presence => true
  validates :food, :presence => true
end
