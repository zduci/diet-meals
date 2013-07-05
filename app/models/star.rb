class Star < ActiveRecord::Base
  attr_accessible :meal_diet_classification_id, :user
  validates :user_id, :presence => true, :uniqueness => { :scope => [:meal_diet_classification_id] }
  validates :meal_diet_classification_id, :presence => true

  belongs_to :meal_diet_classification, :counter_cache => true
  belongs_to :user
  has_one :meal, :through => :meal_diet_classification
  has_one :diet, :through => :meal_diet_classification

  def self.create_star(meal_diet_classification_id, user)
    new(:meal_diet_classification_id => meal_diet_classification_id, :user => user).save
  end

  def self.delete_star(meal_diet_classification_id, user)
    star = find_by_meal_diet_classification_id_and_user_id!(meal_diet_classification_id, user)
    star.destroy
    true
  rescue ActiveRecord::RecordNotFound => e
    false
  end
end
