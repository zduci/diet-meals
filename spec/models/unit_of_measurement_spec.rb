require 'spec_helper'

describe UnitOfMeasurement do
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
    UnitOfMeasurement.should_receive(:create!).with(:name => 'meter', :short_name => 'm')
    UnitOfMeasurement.create_unit_of_measurement('meter', 'm')
  end
end
