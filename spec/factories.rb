FactoryGirl.define do
  factory :fruit, :class => Food do
    name :fruit
  end

  factory :orange, :class => Food do
    name :orange
  end
end
