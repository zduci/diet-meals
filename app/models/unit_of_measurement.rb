class UnitOfMeasurement < ActiveRecord::Base
  attr_accessible :name, :short_name

  has_many :ingredients, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  validates :short_name, :presence => true, :uniqueness => { :case_sensitive => false }

  PIECE = UnitOfMeasurement.find_or_create_by_name_and_short_name('piece', 'x')

  def self.create_unit_of_measurement(name, short_name)
    create!(:name => name, :short_name => short_name)
  end

  def self.find_by_short_name(short_name)
    if short_name.present?
      super(short_name)
    else
      PIECE
    end
  end
end
