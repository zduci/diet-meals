require 'spec_helper'

describe UnitOfMeasurement do
  it 'can create a valid object' do
    FactoryGirl.build(:unit_of_measurement).should  be_valid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:unit_of_measurement, :name  => nil).should  be_invalid
  end

  it 'is invalid without a short name' do
    FactoryGirl.build(:unit_of_measurement, :short_name => nil).should  be_invalid
  end

  it 'is invalid without a unique name' do
    FactoryGirl.create(:unit_of_measurement, :name => 'meter', :short_name => 'm')
    FactoryGirl.build(:unit_of_measurement, :name => 'meter', :short_name => 'unique').should be_invalid
  end

  it 'is invalid without a unique short name' do
    FactoryGirl.create(:unit_of_measurement, :name => 'meter', :short_name => 'm')
    FactoryGirl.build(:unit_of_measurement, :name => 'unique', :short_name => 'm').should be_invalid
  end

  it 'creates a new instance by name and short name' do
    UnitOfMeasurement.should_receive(:create!).with(:name => 'meter', :short_name => 'm')
    UnitOfMeasurement.create_unit_of_measurement('meter', 'm')
  end
end
