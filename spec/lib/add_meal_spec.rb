require 'spec_helper'
require_relative '../../lib/add_meal'

describe AddMeal do
  describe '#add' do
    it 'creates a new meal' do
      Meal.should_receive(:create_meal).with('boiled eggs', 'boil the eggs, add salt', 5)
      AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5)
    end

    it 'creates the ingredients for the new meal'
    it 'classifies the meal into diets'
  end
end
