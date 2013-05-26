require 'spec_helper'

describe DietFoodConnection do
  let(:diet) { FactoryGirl.create(:eggs_only) }
  let(:food) { FactoryGirl.create(:egg) }

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

  it 'is invalid without an unique food' do
    FactoryGirl.create(:diet_food_connection, :diet => diet, :food => food, :allowed => true)
    FactoryGirl.build(:diet_food_connection, :diet => diet, :food => food, :allowed => true).should be_invalid
  end

  it 'is invalid without a boolean allowed attribute' do
    FactoryGirl.build(:diet_food_connection, :diet => diet, :food => food, :allowed => nil).should be_invalid
  end

  it 'checks if it is allowed' do
    FactoryGirl.build(:diet_food_connection, :diet => diet, :food => food, :allowed => false).should be_forbidden
  end

  it 'can create allowed connections' do
    DietFoodConnection.create_allowed(diet, food).should be_allowed
  end

  it 'can create forbidden connections' do
    DietFoodConnection.create_forbidden(diet, food).should be_forbidden
  end
end
