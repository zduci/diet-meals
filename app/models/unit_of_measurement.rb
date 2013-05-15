class UnitOfMeasurement < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true
  validates :short_name, :presence => true
end
