FactoryGirl.define do
  factory :diet, :aliases => [:eggs_only] do
    name 'Eggs only'
    exclusive true
  end

  factory :carrots_only, :class => :diet do
    name 'Carrots only'
    exclusive true
  end
end
