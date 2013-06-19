class Star < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :meal_id, :presence => true
  validates :diet_id, :presence => true
end
