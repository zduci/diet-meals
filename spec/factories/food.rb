FactoryGirl.define do
  factory :food do
  end

  factory :egg, :class => :food do
    name 'egg'
  end

  factory :carrot, :class => :food do
    name 'carrot'
  end
end
