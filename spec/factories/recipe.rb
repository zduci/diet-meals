FactoryGirl.define do
  factory :recipe do
  end

  factory :boiled_egg, :class => :recipe do
    name 'Boiled egg'
    instructions 'Boil the egg.'
  end

  factory :boiled_carrot, :class => :recipe do
    name 'Boiled carrot'
    instructions 'Boil the carrot.'
  end
end
