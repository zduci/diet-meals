class Star < ActiveRecord::Base
  validates :user_id, :presence => true, :uniqueness => { :scope => [:meal_id, :diet_id] }
  validates :meal_id, :presence => true
  validates :diet_id, :presence => true

  belongs_to :meal
  belongs_to :diet
  belongs_to :user
end
