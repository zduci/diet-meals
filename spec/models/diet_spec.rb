require 'spec_helper'

describe Diet do
  context 'validations' do
    it 'can create a valid instance' do
      FactoryGirl.build(:diet).should be_valid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:diet, :name => nil).should be_invalid
    end

    it 'is invalid without an exclusive attribute' do
      FactoryGirl.build(:diet, :exclusive => nil).should be_invalid
    end

    it 'is invalid without a unique name' do
      FactoryGirl.create(:diet, :name => 'Slow Carb Diet')
      FactoryGirl.build(:diet, :name => 'Slow Carb Diet').should be_invalid
    end

    it 'is valid for inclusive diets' do
      FactoryGirl.build(:diet, :exclusive => true).should be_valid
    end
  end

  describe 'Diet#inclusive?' do
    it 'checks if it is inclusive' do
      FactoryGirl.build(:diet, :exclusive => false).should be_inclusive
    end

    it 'checks if it is inclusive' do
      FactoryGirl.build(:diet, :exclusive => true).should be_exclusive
    end
  end

  describe 'Diet#has_allowed_foods?' do
    it 'returns true if it has allowed foods' do
      FactoryGirl.build(:diet, :allowed_foods => [FactoryGirl.build(:food)]).should have_allowed_foods
    end
    
    it 'returns false if it does not have allowed foods' do
      FactoryGirl.build(:diet, :allowed_foods => []).should_not have_allowed_foods
    end
  end

  context 'constructors' do
    it 'creates inclusive diets' do
      Diet.should_receive(:create!).with(:name => 'inclusive diet', :exclusive => false)
      Diet.create_inclusive('inclusive diet')
    end

    it 'creates exclusive diets' do
      Diet.should_receive(:create!).with(:name => 'exclusive diet', :exclusive => true)
      Diet.create_exclusive('exclusive diet')
    end
  end
end
