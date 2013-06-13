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
    it "is named 'piece'" do
      UnitOfMeasurement::PIECE.name.should == 'piece'
    end
  end

end
