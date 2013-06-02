require 'spec_helper'
require_relative '../../lib/add_meal.rb'

describe AddMeal do
  before(:each) do
    egg = FactoryGirl.create(:food, :name => :egg)
    salt = FactoryGirl.create(:food, :name => :salt)
    allows_eggs = FactoryGirl.create(:diet, :name => 'allows eggs', :exclusive => true, :allowed_foods => [egg])
    allows_nothing = FactoryGirl.create(:diet, :name => 'do not eat', :exclusive => true)
  end

  it 'can create meals' do
    boiled_egg = AddMeal.add('boiled eggs', 'boil the eggs, add salt', [{:name => 'egg', :quantity => 2}, {:name => 'salt', :quantity => 1, :unit_of_measurement => 'g'}], 5)

    boiled_egg.name.should == 'boiled egg'
    boiled_egg.instructions.should == 'boil the egg, add salt'
    boiled_egg.time.should == 5
    boiled_egg.foods.should =~ [egg, salt]

    boiled_egg.ingredients.first.name.should == 'egg'
    boiled_egg.ingredients.first.quantity.should == 2
    boiled_egg.ingredients.first.unit_of_measurement.should == UnitOfMeasurement.PIECE 

    boiled_egg.ingredients.first.name.should == 'salt'
    boiled_egg.ingredients.first.quantity.should == 1
    boiled_egg.ingredients.first.unit_of_measurement.name.should == 'gram'
    boiled_egg.ingredients.first.unit_of_measurement.short_name.should == 'g'

    boiled_egg.diets.should == [allows_eggs]
  end
end
