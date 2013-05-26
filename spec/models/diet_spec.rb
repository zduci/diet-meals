require 'spec_helper'

describe Diet do
  context 'validations' do
    it 'can create a valid instance' do
      FactoryGirl.build(:diet, :name => 'Slow Carb Diet', :exclusive => true).should be_valid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:diet, :exclusive => true).should be_invalid
    end

    it 'is invalid without an exclusive attribute' do
      FactoryGirl.build(:diet, :name => 'Slow Carb Diet').should be_invalid
    end

    it 'is invalid without a unique name' do
      FactoryGirl.create(:diet, :name => 'Slow Carb Diet', :exclusive => true)
      FactoryGirl.build(:diet, :name => 'Slow Carb Diet', :exclusive => true).should be_invalid
    end

    it 'is valid for inclusive diets' do
      FactoryGirl.build(:diet, :name => 'Inclusive diet', :exclusive => true).should be_valid
    end
  end

  describe 'Diet#inclusive?' do
    it 'checks if it is inclusive' do
      FactoryGirl.build(:diet, :exclusive => false).should be_inclusive
    end

    it 'checks if it is inclusive' do
      FactoryGirl.build(:diet, :exclusive => true).should_not be_inclusive
    end
  end

  context 'constructors' do
    it 'creates inclusive diets' do
      Diet.create_inclusive('inclusive diet').should be_inclusive
    end

    it 'creates exclusive diets' do
      Diet.create_exclusive('exclusive diet').should be_exclusive
    end
  end
end
