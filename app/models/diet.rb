class Diet < ActiveRecord::Base
  attr_accessible :name, :exclusive

  has_many :diet_food_connections
  has_many :allowed_foods, 
           :conditions => 'allowed = true',
           :through => :diet_food_connections,
           :source => :food,
           :dependent => :destroy
  has_many :diet_food_connections
  has_many :forbidden_foods, 
           :conditions => 'allowed = false',
           :through => :diet_food_connections,
           :source => :food,
           :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
end
