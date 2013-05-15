class UnitOfMeasurement < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :ingredients, :dependent => :destroy
end
