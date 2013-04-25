class Recipe < ActiveRecord::Base
  attr_accessible :duration, :instructions, :ingredients
  has_many :ingredients
end
