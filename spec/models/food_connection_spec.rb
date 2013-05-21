require 'spec_helper'

describe FoodConnection do
  let(:fruit) { FactoryGirl.create(:food, :name => :fruit) }
  let(:orange) { FactoryGirl.create(:food, :name => :orange) }

  it 'creates a connection between foods if it does not exist' do
    FoodConnection.connect(fruit, orange)

    orange.parent_foods.should == [fruit]
    fruit.child_foods.should == [orange]
  end

  it 'does not create a connection between foods if it already exists' do
    FoodConnection.connect(fruit, orange)
    FoodConnection.should_not_receive(:create)
    FoodConnection.connect(fruit, orange)
  end
end
