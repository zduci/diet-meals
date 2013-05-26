FactoryGirl.define do
  factory :food do
    name 'egg'
  end

  factory :food_connection do
  end

  factory :unit_of_measurement do
    name 'gram'
    short_name 'g'
  end

  factory :diet do
    name 'Only eggs'
    exclusive true
  end

  factory :ingredient do
  end

  factory :recipe do
    name 'Boiled egg'
    instructions 'Boil the egg.'
  end

  factory :diet_food_connection do
  end
end
