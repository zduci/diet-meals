FactoryGirl.define do
  factory :recipe, :aliases => [:boiled_egg] do
    name 'Boiled egg'
    instructions 'Boil the egg.'
  end

  factory :boiled_carrot, :class => :recipe do
    name 'Boiled carrot'
    instructions 'Boil the carrot.'
  end
end
