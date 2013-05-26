require 'spec_helper'

describe DietFoodConnection do
  let(:diet) { FactoryGirl.create(:diet) }
  let(:food) { FactoryGirl.create(:food) }
  let(:allowed) { FactoryGirl.create(:diet) }

  it 'can create a valid instance' do
    FactoryGirl.build(:diet_food_connection, :diet => diet, :food => food, :allowed => true).should be_valid
  end

  it 'is invalid without a diet' do
    FactoryGirl.build(:diet_food_connection, :food => food, :allowed => true).should be_invalid
  end

  it 'is invalidwithout a food' do
    FactoryGirl.build(:diet_food_connection, :diet => diet, :allowed => true).should be_invalid
  end

  it 'is invalid without an allowed attribute' do
    FactoryGirl.build(:diet_food_connection, :diet => diet, :food => food).should be_invalid
  end
end
