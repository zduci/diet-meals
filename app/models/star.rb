class Star < ActiveRecord::Base
  attr_accessible :meal_diet_classification_id
  validates :user_id, :presence => true, :uniqueness => { :scope => [:meal_diet_classification_id] }
  validates :meal_diet_classification_id, :presence => true

  belongs_to :meal_diet_classification, :counter_cache => true
  belongs_to :user
  has_one :meal, :through => :meal_diet_classification
  has_one :diet, :through => :meal_diet_classification
end
