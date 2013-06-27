require 'spec_helper'

describe MealDietClassification do
  describe 'validations' do
    let(:meal_diet_classification) { FactoryGirl.build(:meal_diet_classification) }

    it 'can create a valid instance' do
      meal_diet_classification.should be_valid
    end

    it { should validate_presence_of :meal_id }

    it { should validate_presence_of :diet_id }
  end

  context 'associations' do
    it { should belong_to(:meal) }

    it { should belong_to(:diet) }
  end

  describe 'DietClassification#create_classifiction' do
    it 'creates instances with meal and diet' do
      meal = FactoryGirl.create(:meal)
      diet = FactoryGirl.create(:diet)
      diet_classification = MealDietClassification.create_classification(meal, diet)
      MealDietClassification.find_by_meal_id_and_diet_id(meal.id, diet.id).should == diet_classification
    end
  end
end
