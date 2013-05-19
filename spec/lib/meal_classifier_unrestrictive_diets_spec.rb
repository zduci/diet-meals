require 'meal_classifier'

describe MealClassifier do
  let(:empty_meal) { stub(:foods => []) }

  let(:carbs) { stub(:carbs, :parent_foods => []) }
  let(:rice) { stub(:rice, :parent_foods => [carbs], :child_foods => []) }
  let(:brown_rice) { stub(:rice, :parent_foods => [rice], :child_foods => []) }

  let(:rice_meal) { stub(:foods => [rice]) }
  let(:brown_rice_meal) { stub(:foods => [brown_rice]) }

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