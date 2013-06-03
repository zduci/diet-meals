require 'spec_helper'
require_relative '../../lib/add_meal'

describe AddMeal do
  describe '#add' do
    context 'adding a new meal' do
      let(:meal) { stub(:meal, :reload => true)  }
      let(:egg) { stub(:egg)  }
      let(:salt) { stub(:salt)  }
      let(:gram) { stub(:gram) }
      let(:diet) { stub(:diet) }

      before(:each) do
        Meal.stub(:create_meal).with('boiled eggs', 'boil the eggs, add salt', 5) { meal }
        Food.stub(:find_by_name!).with('egg') { egg }
        Food.stub(:find_by_name!).with('salt') { salt }
        UnitOfMeasurement.stub(:find_by_short_name!).with('g') { gram }
        Ingredient.stub(:create_ingredient).with(meal, egg, 2)
        Ingredient.stub(:create_ingredient).with(meal, salt, 1, gram)
        MealClassifier.stub(:classify).with(meal) { [diet] }
        DietClassification.stub(:create_classification).with(meal, diet)
      end

      it 'creates a new meal' do
        Meal.should_receive(:create_meal).with('boiled eggs', 'boil the eggs, add salt', 5)
        AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5)
      end

      it 'creates the ingredients for the new meal' do
        Ingredient.should_receive(:create_ingredient).with(meal, egg, 2)
        Ingredient.should_receive(:create_ingredient).with(meal, salt, 1, gram)
        AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5, {:name => 'egg', :quantity => 2}, {:name => 'salt', :quantity => 1, :unit_of_measurement => 'g'})
      end

      it 'classifies the meal into diets' do
        DietClassification.should_receive(:create_classification).with(meal, diet)
        AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5, {:name => 'egg', :quantity => 2}, {:name => 'salt', :quantity => 1, :unit_of_measurement => 'g'})
      end

      it 'reloads the meal at the end' do
        meal.should_receive(:reload)
        AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5, {:name => 'egg', :quantity => 2}, {:name => 'salt', :quantity => 1, :unit_of_measurement => 'g'})
      end
    end

    context 'error handling' do
      it 'fails for inexistent food name' do
        expect{ AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5, {:name => 'egg', :quantity => 2}) }.to raise_error ActiveRecord::RecordNotFound
      end

      it 'fails for inexistent unit of measurement short name' do
        FactoryGirl.create(:food, :name => 'salt')
        expect{ AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5, {:name => 'salt', :quantity => 1, :unit_of_measurement => 'g'}) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
