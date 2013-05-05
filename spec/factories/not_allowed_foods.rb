# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :not_allowed_food do
    diet_id 1
    food_id 1
  end
end
