require_relative '../../lib/food_graph'
require 'spec_helper'

describe FoodGraph do

  it 'connects foods' do
    orange = FactoryGirl.create(:orange)
    fruit = FactoryGirl.create(:fruit)
    FoodGraph.connect(fruit, orange)

    orange.parent_foods.should == [fruit]
    fruit.child_foods.should == [orange]
  end

end
