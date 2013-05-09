require 'meal_classifier'
require 'spec_helper'

describe MealClassifier do
  let(:simple_restrictive_diet) { stub(:restrictive => true) }
  let(:simple_unrestrictive_diet) { stub(:restrictive => false) }

  context 'unrestrictive diets' do
    it 'checks if meal is compatible with simple diet' do
      MealClassifier.compatible?(simple_unrestrictive_diet, stub).should be_true
    end
  end

  context 'restrictive_diets' do
    it 'checks if meal is compatible with simple diet' do
      MealClassifier.compatible?(simple_restrictive_diet, stub).should be_false
    end
  end
end
