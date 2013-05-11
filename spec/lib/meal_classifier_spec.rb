require 'meal_classifier'

describe MealClassifier do
  let(:empty_restrictive_diet) { stub(:restrictive => true, :allowed_foods => []) }
  let(:empty_unrestrictive_diet) { stub(:restrictive => false, :forbidden_foods => []) }

  let(:carbs) { stub(:carbs, :parent_foods => []) }
  let(:rice) { stub(:rice, :parent_foods => [carbs]) }

  let(:empty_meal) { stub(:ingredients => []) }
  let(:rice_meal) { stub(:ingredients => [rice]) }

  context 'unrestrictive diets' do
    it 'accepts any meal for empty diets' do
      MealClassifier.compatible?(empty_unrestrictive_diet, empty_meal).should be_true
    end

    it 'rejects meals containing forbidden ingredients' do
      no_rice = stub(:restrictive => false, :forbidden_foods => [rice])
      MealClassifier.compatible?(no_rice, rice_meal).should be_false
    end

    it 'rejects meals containing children foods of forbidden ingredients' do
      no_carbs = stub(:restrictive => false, :forbidden_foods => [carbs])
      MealClassifier.compatible?(no_carbs, rice_meal).should be_false
    end
  end

  context 'restrictive_diets' do
    it 'rejects any meal for empty diets' do
      MealClassifier.compatible?(empty_restrictive_diet, empty_meal).should be_false
    end

    it 'accepts meals containing allowed ingredients' do
      allows_rice = stub(:restrictive => true, :allowed_foods => [rice])
      MealClassifier.compatible?(allows_rice, rice_meal).should be_true
    end
  end
end
