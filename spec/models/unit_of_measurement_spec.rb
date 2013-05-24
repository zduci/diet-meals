require 'spec_helper'

describe UnitOfMeasurement do
  it 'can create a valid object' do
    FactoryGirl.build(:unit_of_measurement, :name => 'meter', :short_name => 'm').should  be_valid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:unit_of_measurement, :short_name => 'm').should  be_invalid
  end

  it 'is invalid without a short name' do
    FactoryGirl.build(:unit_of_measurement, :name => 'meter').should  be_invalid
  end
end
