require 'meal_classifier'

describe MealClassifier do
  let(:empty_restrictive_diet) { stub(:restrictive => true) }
  let(:empty_unrestrictive_diet) { stub(:restrictive => false, :forbidden_foods => []) }

  let(:empty_meal) { stub(:ingredients => []) }

  context 'unrestrictive diets' do
    it 'accepts any meal for empty diets' do
      MealClassifier.compatible?(empty_unrestrictive_diet, empty_meal).should be_true
    end

    it 'rejects meals containing forbidden ingredients' do
      rice = stub(:rice)
      no_rice = stub(:restrictive => false, :forbidden_foods => [rice])
      rice_meal = stub(:ingredients => [rice])
      MealClassifier.compatible?(no_rice, rice_meal).should be_false
    end
  end

  context 'restrictive_diets' do
    it 'rejects any meal for empty diets' do
      MealClassifier.compatible?(empty_restrictive_diet, empty_meal).should be_false
    end
  end
end
