require 'spec_helper'

describe Meal do
  context 'validations' do
    let(:meal) { FactoryGirl.build(:meal) }

    it 'can create a valid instance' do
      meal.should be_valid
    end

    it { meal.should validate_presence_of(:instructions) }

    it { meal.should validate_presence_of(:name) }

    it 'is invalid without a duration' do
      FactoryGirl.build(:meal, :duration => nil).should be_invalid
    end

    it 'is invalid if the duration is less than 1' do
      FactoryGirl.build(:meal, :duration => 0).should be_invalid
    end
  end

  context 'associations' do
    it { should have_many(:ingredients) }

    it { should have_many(:foods) }

    it { should have_many(:diets) }
  end

  context '#create_meal' do
    it 'creates a new meal by name, instructions, duration and ingredients' do
      boiled_egg = Meal.create_meal('Boiled egg', 'boil the egg', 30, FactoryGirl.create(:ingredient))
      Meal.find_by_name('Boiled egg').should == boiled_egg
    end
  end
end
