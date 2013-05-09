class ForbiddenFoodConnection < ActiveRecord::Base
  attr_accessible :diet_id, :food_id

  belongs_to :diet
  belongs_to :food
end
