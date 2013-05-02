FactoryGirl.define do
  factory :food do
  end

  factory :orange, :class => Food do
    name :orange
  end
end
