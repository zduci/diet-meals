class DietClassification < ActiveRecord::Base
  attr_accessible :diet, :meal

  validates :meal_id, :presence => true
  validates :diet_id, :presence => true
end
