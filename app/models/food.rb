class Food < ActiveRecord::Base
  has_many :parent_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :child_food_id,
           :dependent => :destroy
  has_many :parent_foods, -> { includes :parent_foods }, :through => :parent_connections

  has_many :child_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :parent_food_id,
           :dependent => :destroy
  has_many :child_foods, -> { includes :child_foods }, :through => :child_connections

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  def self.create_food(name)
    create!(:name => name)
  end

  def self.ordered_by_name
    order(:name)
  end
end
