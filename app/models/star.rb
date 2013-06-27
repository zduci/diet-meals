class Star < ActiveRecord::Base
  validates :user_id, :presence => true, :uniqueness => { :scope => [:meal_id, :diet_id] }
  validates :meal_id, :presence => true
  validates :meal_diet_classification_id, :presence => true

  belongs_to :meal
  belongs_to :meal_diet_classification
  belongs_to :user
end
