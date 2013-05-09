require 'meal_classifier'
require 'spec_helper'

describe MealClassifier do
  let(:simple_restrictive_diet) { stub(:restrictive => true) }
  let(:simple_unrestrictive_diet) { stub(:restrictive => false) }

  context 'classifying meals' do
    it 'returns unrestrictive diets ' do
      Diet.stub(:all) { [simple_unrestrictive_diet] }
      MealClassifier.classify(stub).should == [simple_unrestrictive_diet]
    end

    it 'returns unrestrictive diets ' do
      Diet.stub(:all) { [simple_restrictive_diet] }
      MealClassifier.classify(stub).should == []
    end
  end
end
