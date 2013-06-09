require 'spec_helper'

describe DietFoodConnection do
  let(:diet) { stub(:diet) }
  let(:food) { stub(:food) }

  context 'validations' do
    let(:diet_food_connection) { FactoryGirl.build(:diet_food_connection) }

    it 'can create a valid instance' do
      diet_food_connection.should be_valid
    end

    it { should validate_presence_of(:diet_id) }

    it { should validate_presence_of(:food_id) }

    it 'is invalid without an allowed attribute' do
      FactoryGirl.build(:diet_food_connection, :allowed => nil).should be_invalid
    end

    it 'is invalid without an unique food' do
      egg = FactoryGirl.create(:egg)
      FactoryGirl.create(:diet_food_connection, :food => egg)
      FactoryGirl.build(:diet_food_connection, :food => egg).should be_invalid
    end

    it 'is invalid without a boolean allowed attribute' do
      FactoryGirl.build(:diet_food_connection, :allowed => nil).should be_invalid
    end
  end

  describe 'DietFoodConnection#forbidden?' do
    it 'checks if it is forbidden' do
      FactoryGirl.build(:diet_food_connection, :allowed => false).should be_forbidden
    end
  end

  describe 'alternative constructors' do
    it 'can create allowed connections' do
      DietFoodConnection.should_receive(:create!).with(:diet => diet, :food => food, :allowed => true)
      DietFoodConnection.create_allowed(diet, food)
    end

    it 'can create forbidden connections' do
      DietFoodConnection.should_receive(:create!).with(:diet => diet, :food => food, :allowed => false)
      DietFoodConnection.create_forbidden(diet, food)
    end
  end
end
