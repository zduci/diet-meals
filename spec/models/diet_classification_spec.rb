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
      meal = FactoryGirl.create(:meal)
      diet = FactoryGirl.create(:diet)
      diet_classification = DietClassification.create_classification(meal, diet)
      DietClassification.find_by_meal_id_and_diet_id(meal.id, diet.id).should == diet_classification
    end
  end
end
