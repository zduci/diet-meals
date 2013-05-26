FactoryGirl.define do
  factory :egg, :class => :food do
    name 'egg'
  end

  factory :food do
  end

  factory :food_connection do
  end

  factory :gram, :class => :unit_of_measurement do
    name 'gram'
    short_name 'g'
  end

  factory :unit_of_measurement do
  end

  factory :diet do
  end

  factory :eggs_only, :class => :diet do
    name 'Eggs only'
    exclusive true
  end

  factory :ingredient do
  end

  factory :recipe do
  end

  factory :boiled_egg, :class => :recipe do
    name 'Boiled egg'
    instructions 'Boil the egg.'
  end

  factory :diet_food_connection do
  end
end
