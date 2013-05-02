require_relative '../../lib/food_graph'
require 'spec_helper'

describe FoodGraph do
  let(:fruit) { FactoryGirl.create(:food, :name => :fruit) }
  let(:apple) { FactoryGirl.create(:food, :name => :apple) }
  let(:citrus) { FactoryGirl.create(:food, :name => :citrus) }
  let(:orange) { FactoryGirl.create(:food, :name => :orange) }
  let(:sugar) { FactoryGirl.create(:food, :name => :sugar) }

  def create_connections
    FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => apple)
    FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => citrus)
    FactoryGirl.create(:food_connection, :parent_food => citrus, :child_food => orange)
    FactoryGirl.create(:food_connection, :parent_food => sugar, :child_food => orange)
  end


  it 'creates a connection between foods if it does not exist' do
    FoodGraph.connect(fruit, orange)

    orange.parent_foods.should == [fruit]
    fruit.child_foods.should == [orange]
  end

  it 'does not create a connection between foods if it alreasy exists' do
    FoodGraph.connect(fruit, orange)
    FoodConnection.should_not_receive(:create)
    FoodGraph.connect(fruit, orange)
  end

  it 'retrieves all ancestors' do
    create_connections
    FoodGraph.find_ancestors(orange).should =~ ['fruit', 'citrus', 'sugar']
  end

end


