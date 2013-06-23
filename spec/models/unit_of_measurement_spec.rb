require 'spec_helper'

describe UnitOfMeasurement do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:unit_of_measurement).should  be_valid
    end

    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:short_name) }

    it 'is invalid without a unique name' do
      FactoryGirl.create(:unit_of_measurement, :name => 'meter', :short_name => 'm')
      should validate_uniqueness_of(:name)
    end

    it 'is invalid without a unique short name' do
      FactoryGirl.create(:unit_of_measurement, :name => 'meter', :short_name => 'm')
      should validate_uniqueness_of(:short_name)
    end

    it 'creates a new instance by name and short name' do
      meter = UnitOfMeasurement.create_unit_of_measurement('meter', 'm')
      UnitOfMeasurement.find_by_name('meter').should == meter
    end
  end

  context 'associations' do
    it { should have_many(:ingredients) }
  end

  describe '::PIECE' do
    it "has name 'piece'" do
      UnitOfMeasurement::PIECE.name.should == 'piece'
    end

    it "has short name 'x'" do
      UnitOfMeasurement::PIECE.short_name.should == 'x'
    end
  end

  describe 'UnitOfMeasurement#find_by_short_name!' do
    it 'returns PIECE for empty string' do
      UnitOfMeasurement.find_by_short_name!('').should == UnitOfMeasurement::PIECE
    end

    it 'returns a unit of measurement by short name for present string' do
      cm = FactoryGirl.create(:unit_of_measurement, :short_name => 'cm')
      UnitOfMeasurement.find_by_short_name!('cm').should == cm
    end
  end

  context 'select forms' do
    it 'returns the options for a select form' do
      FactoryGirl.create(:unit_of_measurement, :name => 'meter', :short_name => 'm')
      FactoryGirl.create(:unit_of_measurement, :name => 'gram', :short_name => 'g')
      UnitOfMeasurement.options_for_select.should =~ [['meters', 'm'], ['grams', 'g']]
    end
  end
end
