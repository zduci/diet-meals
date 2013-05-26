FactoryGirl.define do
  factory :gram, :class => :unit_of_measurement do
    name 'gram'
    short_name 'g'
  end

  factory :unit_of_measurement do
  end
end
