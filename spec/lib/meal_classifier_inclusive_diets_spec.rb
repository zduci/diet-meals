require 'meal_classifier'

describe MealClassifier do
  let(:empty_meal) { double(:foods => []) }

  let(:carbs) { double(:carbs, :parent_foods => []) }
  let(:rice) { double(:rice, :parent_foods => [carbs], :child_foods => []) }
  let(:brown_rice) { double(:rice, :parent_foods => [rice], :child_foods => []) }

  let(:rice_meal) { double(:foods => [rice]) }
  let(:brown_rice_meal) { double(:foods => [brown_rice]) }

  let(:empty_inclusive_diet) { double(:exclusive? => false, :forbidden_foods => [], :allowed_foods => []) }
  let(:no_carbs) { double(:exclusive? => false, :forbidden_foods => [carbs], :allowed_foods => []) }

  it 'accepts any meal for empty diets' do
    MealClassifier.compatible?(empty_inclusive_diet, empty_meal).should be_true
  end

  it 'rejects meals containing forbidden foods' do
    no_rice = double(:exclusive? => false, :forbidden_foods => [rice], :allowed_foods => [])
    MealClassifier.compatible?(no_rice, rice_meal).should be_false
  end

  it 'rejects meals containing child foods of forbidden foods' do
    MealClassifier.compatible?(no_carbs, rice_meal).should be_false
  end

  it 'rejects meals containing descendant foods of forbidden foods' do
    MealClassifier.compatible?(no_carbs, brown_rice_meal).should be_false
  end

  it 'accepts meals containing allowed foods with forbidden parent foods' do
    no_carbs_except_rice = double(:exclusive? => false, :forbidden_foods => [carbs], :allowed_foods => [rice])
    MealClassifier.compatible?(no_carbs_except_rice, rice_meal).should be_true
  end

  it 'accepts meals containing allowed foods with forbidden ancestor foods' do
    no_carbs_except_brown_rice = double(:exclusive? => false, :forbidden_foods => [carbs], :allowed_foods => [brown_rice])
    MealClassifier.compatible?(no_carbs_except_brown_rice, brown_rice_meal).should be_true
  end
end
