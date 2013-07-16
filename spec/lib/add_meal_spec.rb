require 'spec_helper'
require_relative '../../lib/add_meal'

describe AddMeal do
  describe '#from_params' do
    let(:duration) { '3' }
    let(:duration_hours) { '0' }
    let(:duration_minutes) { '3' }
    let(:ingredient) { stub(:ingredient) }
    let(:user_id) { 1 }
    let(:user) { stub(:user, :id => user_id) }
    let(:meal_params) { 
                      { :duration_hours => duration_hours,
                        :duration_minutes => duration_minutes,
                        :ingredients_attributes => {'0' => ingredient}} }
    let(:meal_params_with_duration_and_user) { 
                      { :duration => duration,
                        :user_id => user_id,
                        :ingredients_attributes => {'0' => ingredient}} }

    let(:meal) { stub(:meal, :save => true) }
    let(:diet) { stub }

    before(:each) do
      MealDuration.stub(:to_minutes).with(duration_hours, duration_minutes) { duration }
    end

    def add_meal
      AddMeal.from_params(meal_params, user)
    end

    it 'creates a new meal' do
      Meal.should_receive(:new).with(meal_params_with_duration_and_user) { meal }
      meal.should_receive(:save)
      MealClassifier.stub(:classify).with(meal) { [diet] }
      MealDietClassification.stub(:create_classification).with(meal, diet)
      add_meal
    end

    it 'classifies the meal into diets' do
      Meal.stub(:new).with(meal_params_with_duration_and_user) { meal }
      MealClassifier.stub(:classify).with(meal) { [diet] }
      MealDietClassification.should_receive(:create_classification).with(meal, diet)
      add_meal
    end

    it 'returns the meal at the end' do
      Meal.stub(:new).with(meal_params_with_duration_and_user) { meal }
      MealClassifier.stub(:classify).with(meal) { [diet] }
      MealDietClassification.stub(:create_classification).with(meal, diet)
      add_meal.should == meal
    end

    it 'returns the meal is it fails to save' do
      Meal.stub(:new).with(meal_params_with_duration_and_user) { meal }
      meal.stub(:save) { false }
      MealClassifier.should_not_receive(:classify)
      add_meal.should == meal
    end
  end
end
