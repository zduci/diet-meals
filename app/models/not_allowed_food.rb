class NotAllowedFood < ActiveRecord::Base
  attr_accessible :diet_id, :food_id
end
