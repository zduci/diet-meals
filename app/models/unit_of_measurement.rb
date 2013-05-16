class UnitOfMeasurement < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :short_name, :presence => true, :uniqueness => { :case_sensitive => false }
end
