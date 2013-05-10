require 'meal_classifier'

describe MealClassifier do
  let(:empty_restrictive_diet) { stub(:restrictive => true) }
  let(:empty_unrestrictive_diet) { stub(:restrictive => false) }

  let(:empty_diet) { stub(:empty_diet) }

  context 'unrestrictive diets' do
    it 'accepts any meal for empty diets' do
      MealClassifier.compatible?(empty_unrestrictive_diet, empty_diet).should be_true
    end
  end

  context 'restrictive_diets' do
    it 'rejects any meal for empty diets' do
      MealClassifier.compatible?(empty_restrictive_diet, empty_diet).should be_false
    end
  end
end
