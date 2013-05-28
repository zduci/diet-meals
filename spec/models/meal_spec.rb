require 'spec_helper'

describe Meal do
  context 'validations' do
    it 'can create a valid instance with no duration' do
      FactoryGirl.build(:meal, :duration => nil).should be_valid
    end

    it 'can create a valid instance with duration' do
      FactoryGirl.build(:meal, :duration => 30).should be_valid
    end

    it 'is invalid without instructions' do
      FactoryGirl.build(:meal, :instructions => nil).should be_invalid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:meal, :name => nil).should be_invalid
    end

    it 'is invalid if the duration is less than 1' do
      FactoryGirl.build(:meal, :duration => 0).should be_invalid
    end
  end

  context 'alternative constructors' do
    it 'creates a new meal by name and instructions' do
      Meal.should_receive(:create!).with(:name => 'Boiled egg', :instructions => 'boil the egg')
      Meal.create_meal('Boiled egg', 'boil the egg')
    end

    it 'creates a new meal by name, instructions and duration' do
      Meal.should_receive(:create!).with(:name => 'Boiled egg', :instructions => 'boil the egg', :duration => 30)
      Meal.create_meal('Boiled egg', 'boil the egg', 30)
    end
  end
end
