require 'spec_helper'

describe Meal do
  context 'validations' do
    it 'can create a valid instance' do
      FactoryGirl.build(:meal).should be_valid
    end

    it 'is invalid without instructions' do
      FactoryGirl.build(:meal, :instructions => nil).should be_invalid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:meal, :name => nil).should be_invalid
    end

    it 'is invalid without a duration' do
      FactoryGirl.build(:meal, :duration => nil).should be_invalid
    end

    it 'is invalid if the duration is less than 1' do
      FactoryGirl.build(:meal, :duration => 0).should be_invalid
    end
  end

  context '#create_meal' do
    it 'creates a new meal by name, instructions, duration and ingredients' do
      ingredient = stub(:ingredient)
      Meal.should_receive(:create!).with(:name => 'Boiled egg', :instructions => 'boil the egg', :duration => 30, :ingredients => [ingredient])
      Meal.create_meal('Boiled egg', 'boil the egg', 30, ingredient)
    end
  end
end
