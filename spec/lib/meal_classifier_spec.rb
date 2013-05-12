require 'meal_classifier'

describe MealClassifier do
  let(:empty_meal) { stub(:ingredients => []) }

  context 'unrestrictive diets' do
    let(:carbs) { stub(:carbs, :parent_foods => []) }
    let(:rice) { stub(:rice, :parent_foods => [carbs], :child_foods => []) }
    let(:brown_rice) { stub(:rice, :parent_foods => [rice], :child_foods => []) }

    let(:rice_meal) { stub(:ingredients => [rice]) }
    let(:brown_rice_meal) { stub(:ingredients => [brown_rice]) }

    let(:empty_unrestrictive_diet) { stub(:restrictive => false, :forbidden_foods => [], :allowed_foods => []) }
    let(:no_carbs) { stub(:restrictive => false, :forbidden_foods => [carbs], :allowed_foods => []) }

    it 'accepts any meal for empty diets' do
      MealClassifier.compatible?(empty_unrestrictive_diet, empty_meal).should be_true
    end

    it 'rejects meals containing forbidden ingredients' do
      no_rice = stub(:restrictive => false, :forbidden_foods => [rice], :allowed_foods => [])
      MealClassifier.compatible?(no_rice, rice_meal).should be_false
    end

    it 'rejects meals containing child foods of forbidden ingredients' do
      MealClassifier.compatible?(no_carbs, rice_meal).should be_false
    end

    it 'rejects meals containing descendant foods of forbidden ingredients' do
      MealClassifier.compatible?(no_carbs, brown_rice_meal).should be_false
    end

    it 'accepts meals containing allowed ingredients with forbidden parent foods' do
      no_carbs_except_rice = stub(:restrictive => false, :forbidden_foods => [carbs], :allowed_foods => [rice])
      MealClassifier.compatible?(no_carbs_except_rice, rice_meal).should be_true
    end

    it 'accepts meals containing allowed ingredients with forbidden ancestor foods' do
      no_carbs_except_brown_rice = stub(:restrictive => false, :forbidden_foods => [carbs], :allowed_foods => [brown_rice])
      MealClassifier.compatible?(no_carbs_except_brown_rice, brown_rice_meal).should be_true
    end
  end

  context 'restrictive_diets' do
    let(:meat) { stub(:meat, :child_foods => [chicken]) }
    let(:chicken) { stub(:chicken, :child_foods => [chicken_breast]) }
    let(:chicken_breast) { stub(:chicken_breast, :child_foods => []) }

    let(:chicken_meal) { stub(:ingredients => [chicken]) }
    let(:chicken_breast_meal) { stub(:ingredients => [chicken_breast]) }

    let(:allows_meat) { stub(:restrictive => true, :allowed_foods => [meat], :forbidden_foods => []) }
    let(:empty_restrictive_diet) { stub(:restrictive => true, :allowed_foods => [], :forbidden_foods => []) }

    it 'rejects any meal for empty diets' do
      MealClassifier.compatible?(empty_restrictive_diet, empty_meal).should be_false
    end

    it 'accepts meals containing allowed ingredients' do
      allows_chicken = stub(:restrictive => true, :allowed_foods => [chicken], :forbidden_foods => [])
      MealClassifier.compatible?(allows_chicken, chicken_meal).should be_true
    end

    it 'accepts meals containing child foods of alowed ingredients' do
      MealClassifier.compatible?(allows_meat, chicken_meal).should be_true
    end

    it 'accepts meals containing descendant foods of alowed ingredients' do
      MealClassifier.compatible?(allows_meat, chicken_breast_meal).should be_true
    end

    it 'rejects meals containing forbidden ingredients with accepted parent foods' do
      allows_meat_except_chicken = stub(:restrictive => true, :forbidden_foods => [chicken], :allowed_foods => [meat])
      MealClassifier.compatible?(allows_meat_except_chicken, chicken_meal).should be_false
    end
  end
end
