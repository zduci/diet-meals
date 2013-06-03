require 'spec_helper'
require_relative '../../lib/add_meal.rb'

describe AddMeal do
  before(:each) do
    @egg = FactoryGirl.create(:food, :name => :egg)
    @salt = FactoryGirl.create(:food, :name => :salt)
    gram = FactoryGirl.create(:unit_of_measurement, :name => 'gram', :short_name => 'g')
    @allows_eggs = FactoryGirl.create(:diet, :name => 'allows eggs', :exclusive => true, :allowed_foods => [@egg, @salt])
    allows_nothing = FactoryGirl.create(:diet, :name => 'do not eat', :exclusive => true)
  end

  it 'can create meals' do
    boiled_egg = AddMeal.add('boiled eggs', 'boil the eggs, add salt', 5, {:name => 'egg', :quantity => 2}, {:name => 'salt', :quantity => 1, :unit_of_measurement => 'g'})

    boiled_egg.diets.should == [@allows_eggs]
  end
end
