require 'spec_helper'

describe Diet do
  context 'validations' do
    it 'can create a valid instance' do
      FactoryGirl.build(:diet).should be_valid
    end

    it { should validate_presence_of(:name) }

    it 'is invalid without an exclusive attribute' do
      FactoryGirl.build(:diet, :exclusive => nil).should be_invalid
    end

    it 'is invalid without a unique name' do
      FactoryGirl.create(:diet, :name => 'Slow Carb Diet')
      should validate_uniqueness_of(:name)
    end

    it 'is valid for inclusive diets' do
      FactoryGirl.build(:diet, :exclusive => false).should be_valid
    end
  end

  context 'associations' do
    it { should have_many(:allowed_foods) }

    it { should have_many(:forbidden_foods) }

    it { should have_many(:diet_classifications) }

    it { should have_many(:meals) }
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
      Diet.create_inclusive('inclusive diet').should be_inclusive
    end

    it 'creates exclusive diets' do
      Diet.create_exclusive('exclusive diet').should be_exclusive
    end
  end
end
