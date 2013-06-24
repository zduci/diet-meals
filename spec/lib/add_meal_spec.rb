require 'spec_helper'
require_relative '../../lib/add_meal'

describe AddMeal do
  describe '#add' do
    context 'adding a new meal' do
      let(:meal) { stub(:meal, :reload => true)  }
      let(:egg) { stub(:egg)  }
      let(:salt) { stub(:salt)  }
      let(:gram) { stub(:gram) }
      let(:piece) { stub(:piece) }
      let(:diet) { stub(:diet) }

      before(:each) do
        Meal.stub(:create_meal).with('boiled eggs', 'boil the eggs, add salt', '5') { meal }
        Food.stub(:find_by_name!).with('egg') { egg }
        Food.stub(:find_by_name!).with('salt') { salt }
        UnitOfMeasurement.stub(:find_by_short_name!).with('g') { gram }
        UnitOfMeasurement.stub(:find_by_short_name!).with('') { piece }
        Ingredient.stub(:create_ingredient).with(meal, egg, '2', piece)
        Ingredient.stub(:create_ingredient).with(meal, salt, '1', gram)
        MealClassifier.stub(:classify).with(meal) { [diet] }
        DietClassification.stub(:create_classification).with(meal, diet)
      end

      def add_meal
        AddMeal.add('boiled eggs', 'boil the eggs, add salt', '5', {:food => {:name => 'egg'}, :quantity => '2', :unit_of_measurement => {:short_name => ''}}, {:food => {:name => 'salt'}, :quantity => '1', :unit_of_measurement =>{ :short_name =>'g'}})
      end

      it 'creates a new meal' do
        Meal.should_receive(:create_meal).with('boiled eggs', 'boil the eggs, add salt', '5')
        add_meal
      end

      it 'creates the ingredients for the new meal' do
        Ingredient.should_receive(:create_ingredient).with(meal, egg, '2', piece)
        Ingredient.should_receive(:create_ingredient).with(meal, salt, '1', gram)
        add_meal
      end

      it 'classifies the meal into diets' do
        DietClassification.should_receive(:create_classification).with(meal, diet)
        add_meal
      end

      it 'reloads the meal at the end' do
        meal.should_receive(:reload)
        add_meal
      end
    end

    context 'error handling' do
      it 'fails for inexistent food name' do
        expect{ 
          AddMeal.add('boiled eggs', 'boil the eggs, add salt', '5', 
                      { :food => {:name => 'does not exist'}, 
                        :quantity => '2'}) 
        }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'fails for inexistent unit of measurement short name' do
        FactoryGirl.create(:food, :name => 'salt')
        expect{ 
          AddMeal.add('boiled eggs', 'boil the eggs, add salt', '5', 
                      { :food => {:name => 'salt'}, 
                        :quantity => '1', 
                        :unit_of_measurement => { :short_name => 'does not exist'}}) 
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe '#from_params' do
    let(:name) { 'toast' }
    let(:instructions) { 'toast the bread' }
    let(:duration) { '3' }
    let(:duration_hours) { '0' }
    let(:duration_minutes) { '3' }
    let(:ingredient) { {'food' => { 'name' => 'bread' }, 'quantity' => '2', 'unit_of_measurement' => { 'short_name' => 'slices'}} }
    let(:meal_params) { {:name => name,
                         :instructions => instructions,
                         :duration_hours => duration_hours,
                         :duration_minutes => duration_minutes,
                         :ingredients_attributes => {'0' => ingredient}} }

    it 'calls #add with the correct parameters' do
      MealDuration.stub(:to_minutes).with(duration_hours, duration_minutes) { duration }
      AddMeal.should_receive(:add).with(name, instructions, duration, ingredient)
      AddMeal.from_params(meal_params)
    end
  end
end
