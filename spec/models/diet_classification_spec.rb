require 'spec_helper'

describe DietClassification do
  describe 'validations' do
    it 'can create a valid instance' do
      FactoryGirl.build(:diet_classification).should be_valid
    end

    it 'is not valid without a meal' do
      FactoryGirl.build(:diet_classification, :meal_id => nil).should be_invalid
    end

    it 'is not valid without a diet' do
      FactoryGirl.build(:diet_classification, :diet_id => nil).should be_invalid
    end
  end

  describe 'DietClassification#create_classifiction' do
    it 'creates instances with meal and diet' do
      meal = stub(:meal)
      diet = stub(:diet)
      DietClassification.should_receive(:create!).with(:meal => meal, :diet => diet)
      DietClassification.create_classification(meal, diet)
    end
  end
end
