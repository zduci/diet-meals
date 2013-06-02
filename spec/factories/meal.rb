FactoryGirl.define do
  factory :meal, :aliases => [:boiled_egg] do
    name 'Boiled egg'
    instructions 'Boil the egg.'
    duration 4
  end

  factory :boiled_carrot, :class => :meal do
    name 'Boiled carrot'
    instructions 'Boil the carrot.'
  end
end
