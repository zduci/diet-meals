require 'spec_helper'

describe FoodConnection do
  let(:fruit) { FactoryGirl.create(:food, :name => :fruit) }
  let(:orange) { FactoryGirl.create(:food, :name => :orange) }

  context 'Food#connect' do
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

  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:food_connection).should be_valid
    end

    it { should validate_presence_of(:parent_food_id) }

    it { should validate_presence_of(:child_food_id) }

    it 'is invalid without a unique parent child food pair' do
      FactoryGirl.create(:food_connection, :parent_food => fruit, :child_food => orange)
      should validate_uniqueness_of(:parent_food_id).scoped_to(:child_food_id)
    end
  end

end
