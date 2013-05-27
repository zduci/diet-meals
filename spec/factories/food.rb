FactoryGirl.define do
  factory :food, :aliases => [:egg] do
    name 'egg'
  end

  factory :carrot, :class => :food do
    name 'carrot'
  end
end
