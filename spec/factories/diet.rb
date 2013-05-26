FactoryGirl.define do
  factory :diet do
  end

  factory :eggs_only, :class => :diet do
    name 'Eggs only'
    exclusive true
  end

  factory :carrots_only, :class => :diet do
    name 'Carrots only'
    exclusive true
  end
end
