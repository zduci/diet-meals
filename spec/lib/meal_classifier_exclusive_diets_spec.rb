require 'meal_classifier'

describe MealClassifier do
  let(:empty_meal) { double(:foods => []) }

  let(:meat) { double(:meat, :child_foods => [chicken]) }
  let(:chicken) { double(:chicken, :child_foods => [chicken_breast]) }
  let(:chicken_breast) { double(:chicken_breast, :child_foods => [fat_free_chicken_breast]) }
  let(:fat_free_chicken_breast) { double(:fat_free_chicken_breast, :child_foods => []) }

  let(:chicken_meal) { double(:foods => [chicken]) }
  let(:chicken_breast_meal) { double(:foods => [chicken_breast]) }
  let(:fat_free_chicken_breast_meal) { double(:foods => [fat_free_chicken_breast]) }

  let(:allows_meat) { double(:exclusive? => true, :allowed_foods => [meat], :forbidden_foods => [], :has_allowed_foods? => true) }
  let(:empty_exclusive_diet) { double(:exclusive? => true, :allowed_foods => [], :forbidden_foods => [], :has_allowed_foods? => false) }

  let(:allows_meat_except_chicken) { double(:exclusive? => true, :forbidden_foods => [chicken], :allowed_foods => [meat], :has_allowed_foods? => true) }

  it 'rejects any meal for empty diets' do
    MealClassifier.compatible?(empty_exclusive_diet, empty_meal).should be_false
  end

  it 'accepts meals containing allowed foods' do
    allows_chicken = double(:exclusive? => true, :allowed_foods => [chicken], :forbidden_foods => [], :has_allowed_foods? => true)
    MealClassifier.compatible?(allows_chicken, chicken_meal).should be_true
  end

  it 'accepts meals containing child foods of allowed foods' do
    MealClassifier.compatible?(allows_meat, chicken_meal).should be_true
  end

  it 'accepts meals containing descendant foods of allowed foods' do
    MealClassifier.compatible?(allows_meat, chicken_breast_meal).should be_true
  end

  it 'rejects meals containing forbidden foods with accepted parent foods' do
    MealClassifier.compatible?(allows_meat_except_chicken, chicken_meal).should be_false
  end

  it 'rejects meals containing forbidden foods with accepted ancestor foods' do
    allows_meat_except_chicken_breast = double(:exclusive? => true, :forbidden_foods => [chicken_breast], :allowed_foods => [meat], :has_allowed_foods? => true)
    MealClassifier.compatible?(allows_meat_except_chicken_breast, chicken_breast_meal).should be_false
  end

  it 'rejects meals containing foods with rejected parent foods' do
    MealClassifier.compatible?(allows_meat_except_chicken, chicken_breast_meal).should be_false
  end

  it 'rejects meals containing foods with rejected ancestor foods' do
    MealClassifier.compatible?(allows_meat_except_chicken, fat_free_chicken_breast_meal).should be_false
  end
end
