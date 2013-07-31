class Star < ActiveRecord::Base
  validates :user_id, :presence => true, :uniqueness => { :scope => [:meal_diet_classification_id] }
  validates :meal_diet_classification_id, :presence => true

  belongs_to :meal_diet_classification, :counter_cache => true
  belongs_to :user
  has_one :meal, :through => :meal_diet_classification
  has_one :diet, :through => :meal_diet_classification

  def self.create_star(meal_diet_classification_id, user)
    create!(:meal_diet_classification_id => meal_diet_classification_id, :user => user)
  end
end
