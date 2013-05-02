require_relative '../../lib/food_graph'
require 'spec_helper'

describe FoodGraph do

  it 'creates a connection between foods if it does not exist' do
    orange = FactoryGirl.create(:food, :name => :orange)
    fruit = FactoryGirl.create(:food, :name => :fruit)
    FoodGraph.connect(fruit, orange)

    orange.parent_foods.should == [fruit]
    fruit.child_foods.should == [orange]
  end

  it 'does not create a connection between foods if it alreasy exists' do
    orange = FactoryGirl.create(:food, :name => :orange)
    fruit = FactoryGirl.create(:food, :name => :fruit)


    FoodGraph.connect(fruit, orange)
    FoodConnection.should_not_receive(:create)
    FoodGraph.connect(fruit, orange)
  end

  it 'retrieves all ancestors' do
    fruit = FactoryGirl.create(:food, :name => :fruit)
    apple = FactoryGirl.create(:food, :name => :apple)
    citrus = FactoryGirl.create(:food, :name => :citrus)
    orange = FactoryGirl.create(:food, :name => :orange)
    sugar = FactoryGirl.create(:food, :name => :sugar)
    fruit_apple = FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => apple)
    fruit_citrus = FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => citrus)
    citrus_orange = FactoryGirl.create(:food_connection, :parent_food => citrus, :child_food => orange)
    sugar_orange = FactoryGirl.create(:food_connection, :parent_food => sugar, :child_food => orange)
    FoodGraph.find_ancestors(orange).should =~ ['fruit', 'citrus', 'sugar']
  end

end


