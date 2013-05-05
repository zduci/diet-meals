class Diet < ActiveRecord::Base
  attr_accessible :name

  has_many :allowed_foods
  has_many :allowed, 
           :through => :allowed_foods,
           :source => :food
  has_many :not_allowed_foods
  has_many :not_allowed, 
           :through => :allowed_foods,
           :source => :food
end
