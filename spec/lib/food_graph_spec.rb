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

end
