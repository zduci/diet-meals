class Diet < ActiveRecord::Base
  attr_accessible :name, :exclusive

  has_many :allowed_food_connections
  has_many :allowed_foods, 
           :through => :allowed_food_connections,
           :source => :food,
           :dependent => :destroy
  has_many :forbidden_food_connections
  has_many :forbidden_foods, 
           :through => :forbidden_food_connections,
           :source => :food,
           :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
end
