require 'spec_helper'

describe DietClassification do
  describe 'validations' do
    let(:diet_classification) { FactoryGirl.build(:diet_classification) }

    it 'can create a valid instance' do
      diet_classification.should be_valid
    end

    it { diet_classification.should validate_presence_of :meal_id }

    it { diet_classification.should validate_presence_of :diet_id }
  end

  context 'associations' do
    it { should belong_to(:meal) }

    it { should belong_to(:diet) }
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
