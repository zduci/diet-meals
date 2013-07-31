class MealDietClassification < ActiveRecord::Base
  belongs_to :meal
  belongs_to :diet
  has_many :stars

  validates :meal_id, :presence => true
  validates :diet_id, :presence => true

  def self.create_classification(meal, diet)
    create!(:meal => meal, :diet => diet)
  end

  def self.stars_count(id)
    find(id).stars_count
  end

  def find_star(user)
    stars.find_by_user_id!(user.id)
  end
end
