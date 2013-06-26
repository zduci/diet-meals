require 'spec_helper'
require_relative '../../lib/add_meal'

describe AddMeal do
  describe '#from_params' do
    context 'adding a new meal' do
      let(:name) { 'toast' }
      let(:instructions) { 'toast the bread' }
      let(:duration) { '3' }
      let(:duration_hours) { '0' }
      let(:duration_minutes) { '3' }
      let(:ingredient) { {'food' => { 'name' => 'bread' }, 'quantity' => '2', 'unit_of_measurement' => { 'id' => '13'}} }
      let(:meal_params) { {:name => name,
                         :instructions => instructions,
                         :duration_hours => duration_hours,
                         :duration_minutes => duration_minutes,
                         :ingredients_attributes => {'0' => ingredient}} }
      let(:meal_params_with_duration) { {:name => name,
                         :instructions => instructions,
                         :duration => duration,
                         :ingredients_attributes => {'0' => ingredient}} }
      before(:each) do
        MealDuration.stub(:to_minutes).with(duration_hours, duration_minutes) { duration }
        #MealClassifier.stub(:classify).with(meal) { [diet] }
        #DietClassification.stub(:create_classification).with(meal, diet)
      end

      def add_meal
        AddMeal.from_params(meal_params)
      end

      it 'creates a new meal' do
        meal = stub(:meal, :save => true)
        diet = stub
        Meal.should_receive(:new).with(meal_params_with_duration) { meal }
        meal.should_receive(:save)
        MealClassifier.stub(:classify).with(meal) { [diet] }
        DietClassification.stub(:create_classification).with(meal, diet)
        add_meal
      end

      it 'classifies the meal into diets' do
        meal = stub(:meal, :save => true)
        diet = stub
        Meal.stub(:new).with(meal_params_with_duration) { meal }
        MealClassifier.stub(:classify).with(meal) { [diet] }
        DietClassification.should_receive(:create_classification).with(meal, diet)
        add_meal
      end

      it 'returns the meal at the end' do
        meal = stub(:meal, :save => true)
        diet = stub
        Meal.stub(:new).with(meal_params_with_duration) { meal }
        MealClassifier.stub(:classify).with(meal) { [diet] }
        DietClassification.stub(:create_classification).with(meal, diet)
        add_meal.should == meal
      end
    end
  end
end
