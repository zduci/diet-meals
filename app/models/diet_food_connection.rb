class DietFoodConnection < ActiveRecord::Base
  attr_accessible :diet, :food, :allowed

  belongs_to :diet
  belongs_to :food

  validates :diet_id, :presence => true, :uniqueness => {:scope => :food_id }
  validates :food_id, :presence => true
  validates :allowed, :inclusion => {:in => [true, false]}

  def forbidden?
    !allowed
  end

  def self.create_allowed(diet, food)
    create!(:diet => diet, :food => food, :allowed => true)
  end

  def self.create_forbidden(diet, food)
    create!(:diet => diet, :food => food, :allowed => false)
  end
end
