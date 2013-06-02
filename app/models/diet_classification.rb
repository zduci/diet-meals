class DietClassification < ActiveRecord::Base
  attr_accessible :diet, :meal

  validates :meal_id, :presence => true
  validates :diet_id, :presence => true

  def self.create_classification(meal, diet)
    create!(:meal => meal, :diet => diet)
  end
end
