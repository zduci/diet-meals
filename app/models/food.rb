class Food < ActiveRecord::Base
  attr_accessible :name

  has_many :parent_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :child_food_id,
           :dependent => :destroy
  has_many :parent_foods, :through => :parent_connections, :include => [:parent_foods]

  has_many :child_connections, 
           :class_name => FoodConnection, 
           :foreign_key => :parent_food_id,
           :dependent => :destroy
  has_many :child_foods, :through => :child_connections, :include => [:child_foods]

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }

  def self.create_food(name)
    create!(:name => name)
  end

  def self.all_names
    find(:all, :select => :name).map(&:name)
  end
end
