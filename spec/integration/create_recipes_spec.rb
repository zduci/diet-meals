require 'spec_helper'

describe Meal do
  it 'can create meals' do
    boiled_egg = Meal.create_meal('boiled egg', 'boil the egg')
    boiled_egg.name.should == 'boiled egg'
    boiled_egg.instructions.should == 'boil the egg'
  end
end
