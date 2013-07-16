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

    it { should have_many(:stars) }
  end

  describe 'DietClassification#create_classifiction' do
    it 'creates instances with meal and diet' do
      meal = FactoryGirl.create(:meal)
      diet = FactoryGirl.create(:diet)
      diet_classification = MealDietClassification.create_classification(meal, diet)
      MealDietClassification.find_by_meal_id_and_diet_id(meal.id, diet.id).should == diet_classification
    end
  end

  describe '::stars_count' do
    it 'retrieves the stars count' do
      classification = FactoryGirl.create(:meal_diet_classification)
      FactoryGirl.create(:star, :meal_diet_classification_id => classification.id, :user_id => 1)
      FactoryGirl.create(:star, :meal_diet_classification_id => classification.id, :user_id => 2)

      MealDietClassification.stars_count(classification.id).should == 2
    end
  end

  describe '#find_star' do
    let(:user) { FactoryGirl.create(:user) }

    it "finds a user's star" do
      classification = FactoryGirl.create(:meal_diet_classification)
      star = FactoryGirl.create(:star, :meal_diet_classification_id => classification.id, :user_id => user.id)
      classification.find_star(user).should == star
    end

    it 'raises error if user has not starred this classification' do
      classification = FactoryGirl.create(:meal_diet_classification)
      expect { classification.find_star(user) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
