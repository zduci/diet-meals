class UnitOfMeasurement < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :short_name, :presence => true, :uniqueness => { :case_sensitive => false }

  PIECE = Class.new do
    def self.name
      'piece'
    end
  end

  def self.create_unit_of_measurement(name, short_name)
    create!(:name => name, :short_name => short_name)
  end
end
