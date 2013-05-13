require_relative '../../lib/food_graph'
require 'spec_helper'

describe FoodGraph do
  let(:fruit) { FactoryGirl.create(:food, :name => :fruit) }
  let(:apple) { FactoryGirl.create(:food, :name => :apple) }
  let(:citrus) { FactoryGirl.create(:food, :name => :citrus) }
  let(:orange) { FactoryGirl.create(:food, :name => :orange) }
  let(:sugar) { FactoryGirl.create(:food, :name => :sugar) }

  context 'connections' do
    it 'creates a connection between foods if it does not exist' do
      FoodGraph.connect(fruit, orange)

      orange.parent_foods.should == [fruit]
      fruit.child_foods.should == [orange]
    end

    it 'does not create a connection between foods if it already exists' do
      FoodGraph.connect(fruit, orange)
      FoodConnection.should_not_receive(:create)
      FoodGraph.connect(fruit, orange)
    end
  end

  context 'family graph' do
    before(:each) { create_connections }

    def create_connections
      FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => apple)
      FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => citrus)
      FactoryGirl.create(:food_connection, :parent_food => citrus, :child_food => orange)
      FactoryGirl.create(:food_connection, :parent_food => sugar, :child_food => orange)
    end

    context 'ancestors' do
      it 'retrieves all ancestors' do
        FoodGraph.find_ancestors(orange).should =~ [fruit, citrus, sugar]
      end

      it 'checks for ancestor' do
        FoodGraph.has_ancestor(orange, fruit).should be_true
        FoodGraph.has_ancestor(orange, apple).should be_false
      end

      it 'returns the foods along with their ancestors' do
        FoodGraph.including_ancestors([apple, orange]).should == [apple, orange, fruit, citrus, sugar]
      end
    end

    context 'descendants' do
      it 'retrieves all descendants' do
        FoodGraph.find_descendants(fruit).should =~ [apple, citrus, orange]
      end

      it 'checks for descendant' do
        FoodGraph.has_descendant(citrus, orange).should be_true
        FoodGraph.has_descendant(citrus, apple).should be_false
      end

      it 'returns the foods along with their descendants' do
        FoodGraph.including_descendants([citrus, sugar]).should =~ [citrus, orange, sugar]
      end
    end
  end
end
