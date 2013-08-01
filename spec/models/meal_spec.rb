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

    it { should belong_to(:user) }

    it { should accept_nested_attributes_for(:ingredients) }
  end

  describe '::create_meal' do
    it 'creates a new meal by name, instructions, duration and ingredients' do
      boiled_egg = Meal.create_meal('Boiled egg', 'boil the egg', 30, FactoryGirl.create(:ingredient))
      Meal.find_by_name('Boiled egg').should == boiled_egg
    end
  end

  describe '::new_meal' do
    it 'builds a new meal with 2 ingredients each with a new food' do
      Meal.new_meal.ingredients.size.should == 2
      Meal.new_meal.ingredients.first.food.should_not be_nil
      Meal.new_meal.ingredients.second.food.should_not be_nil
    end
  end

  describe '::popular_classifications' do
    it 'returns the first 5 classifications for this meal ordered by number of stars' do
      boiled_egg = FactoryGirl.create(:meal, :name => 'Boiled egg')

      eat_anything_classification = FactoryGirl.create(:meal_diet_classification, :diet => FactoryGirl.create(:diet, :name => 'eat anything'), :meal => boiled_egg, :stars_count => 1)
      slow_carb_classification = FactoryGirl.create(:meal_diet_classification, :diet => FactoryGirl.create(:diet, :name => 'Slow Carb Diet'), :meal => boiled_egg, :stars_count => 2)
      atkins_classification = FactoryGirl.create(:meal_diet_classification, :diet => FactoryGirl.create(:diet, :name => 'Atkins Diet'), :meal => boiled_egg, :stars_count => 0)
      paleo_classification = FactoryGirl.create(:meal_diet_classification, :diet => FactoryGirl.create(:diet, :name => 'Paleo Diet'), :meal => boiled_egg, :stars_count => 3)
      weight_watchers_classification = FactoryGirl.create(:meal_diet_classification, :diet => FactoryGirl.create(:diet, :name => 'Weight Watchers'), :meal => boiled_egg, :stars_count => 0)
      only_eggs_classification = FactoryGirl.create(:meal_diet_classification, :diet => FactoryGirl.create(:diet, :name => 'Only eat eggs!'), :meal => boiled_egg, :stars_count => 4)

      boiled_egg.popular_classifications.should == [only_eggs_classification, paleo_classification, slow_carb_classification, eat_anything_classification, atkins_classification]
    end
  end

  describe '#author' do
    it 'returns the user who created this meal if there is one' do
      bob = FactoryGirl.create(:user)
      chips = FactoryGirl.create(:meal, :user => bob)
      chips.author.should == bob
    end

    it 'returns the anonymous user if there is no author' do
      fish_cakes = FactoryGirl.create(:meal, :user => nil)
      fish_cakes.author.should == User::ANONYMOUS
    end
  end
end
