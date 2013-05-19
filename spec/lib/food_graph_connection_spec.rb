require 'spec_helper'
require_relative '../../lib/food_graph_connection'

describe FoodGraphConnection do
  let(:fruit) { FactoryGirl.create(:food, :name => :fruit) }
  let(:orange) { FactoryGirl.create(:food, :name => :orange) }

  it 'creates a connection between foods if it does not exist' do
    FoodGraphConnection.create(fruit, orange)

    orange.parent_foods.should == [fruit]
    fruit.child_foods.should == [orange]
  end

  it 'does not create a connection between foods if it already exists' do
    FoodGraphConnection.create(fruit, orange)
    FoodConnection.should_not_receive(:create)
    FoodGraphConnection.create(fruit, orange)
  end
end
