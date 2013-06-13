require 'spec_helper'

describe DietFoodConnection do
  context 'validations' do
    let(:diet_food_connection) { FactoryGirl.build(:diet_food_connection) }

    it 'can create a valid instance' do
      diet_food_connection.should be_valid
    end

    it { should validate_presence_of(:diet_id) }

    it { should validate_presence_of(:food_id) }

    it 'is invalid without an unique food' do
      egg = FactoryGirl.create(:egg)
      FactoryGirl.create(:diet_food_connection, :food => egg)
      FactoryGirl.build(:diet_food_connection, :food => egg).should be_invalid
    end

    it 'is invalid without a boolean allowed attribute' do
      FactoryGirl.build(:diet_food_connection, :allowed => nil).should be_invalid
    end
  end

  context 'associations' do
    it { should belong_to(:diet) }

    it { should belong_to(:food) }
  end

  describe 'DietFoodConnection#forbidden?' do
    it 'checks if it is forbidden' do
      FactoryGirl.build(:diet_food_connection, :allowed => false).should be_forbidden
    end
  end

  describe 'alternative constructors' do
    let(:diet) { FactoryGirl.create(:diet) }
    let(:food) { FactoryGirl.create(:food) }

    it 'can create allowed connections' do
      DietFoodConnection.create_allowed(diet, food).should be_allowed
    end

    it 'can create forbidden connections' do
      DietFoodConnection.create_forbidden(diet, food).should be_forbidden
    end
  end
end
