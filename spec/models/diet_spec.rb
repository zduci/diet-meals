require 'spec_helper'

describe Diet do
  context 'validations' do
    it 'can create a valid instance' do
      FactoryGirl.build(:diet).should be_valid
    end

    it { should validate_presence_of(:name) }

    it 'is invalid without an exclusive attribute' do
      FactoryGirl.build(:diet, :exclusive => nil).should be_invalid
    end

    it 'is invalid without a unique name' do
      FactoryGirl.create(:diet, :name => 'Slow Carb Diet')
      should validate_uniqueness_of(:name)
    end

    it 'is valid for inclusive diets' do
      FactoryGirl.build(:diet, :exclusive => false).should be_valid
    end
  end

  context 'associations' do
    it { should have_many(:allowed_foods) }

    it { should have_many(:forbidden_foods) }

    it { should have_many(:meal_diet_classifications) }

    it { should have_many(:meals) }
  end

  context 'initializers' do
    it 'creates inclusive diets' do
      Diet.create_inclusive('inclusive diet').should be_inclusive
    end

    it 'creates exclusive diets' do
      Diet.create_exclusive('exclusive diet').should be_exclusive
    end
  end

  describe '::popular' do
    it 'returns the first 3 diets' do
      dukan = FactoryGirl.create(:diet, :name => 'Dukan diet')
      atkins = FactoryGirl.create(:diet, :name => 'Atkins diet')
      cambridge = FactoryGirl.create(:diet, :name => 'Cambridge diet')
      weight_watchers = FactoryGirl.create(:diet, :name => 'WeightWatchers diet')
      Diet.popular.should == [dukan, atkins, cambridge]
    end
  end

  describe '#inclusive?' do
    it 'checks if it is inclusive' do
      FactoryGirl.build(:diet, :exclusive => false).should be_inclusive
    end

    it 'checks if it is inclusive' do
      FactoryGirl.build(:diet, :exclusive => true).should be_exclusive
    end
  end

  describe '#has_allowed_foods?' do
    it 'returns true if it has allowed foods' do
      FactoryGirl.build(:diet, :allowed_foods => [FactoryGirl.build(:food)]).should have_allowed_foods
    end
    
    it 'returns false if it does not have allowed foods' do
      FactoryGirl.build(:diet, :allowed_foods => []).should_not have_allowed_foods
    end
  end

  describe "#popular_classifications" do
    it 'returns the first 5 classifications for this diet' do
      eat_anything = FactoryGirl.create(:diet)
      cheese_pizza_classification = FactoryGirl.create(:meal_diet_classification, :meal => FactoryGirl.create(:meal, :name => 'Cheese pizza'), :diet => eat_anything, :stars_count => 0)
      grilled_shrimp_classification = FactoryGirl.create(:meal_diet_classification, :meal => FactoryGirl.create(:meal, :name => 'Grilled Shrimp'), :diet => eat_anything, :stars_count => 0)
      chicken_kebab_classification = FactoryGirl.create(:meal_diet_classification, :meal => FactoryGirl.create(:meal, :name => 'Chicken kebab'), :diet => eat_anything, :stars_count => 0)
      pork_ribs_classification = FactoryGirl.create(:meal_diet_classification, :meal => FactoryGirl.create(:meal, :name => 'Pork ribs'), :diet => eat_anything, :stars_count => 3)
      steak_classification = FactoryGirl.create(:meal_diet_classification, :meal => FactoryGirl.create(:meal, :name => '80z steak'), :diet => eat_anything, :stars_count => 1)
      chips_classification = FactoryGirl.create(:meal_diet_classification, :meal => FactoryGirl.create(:meal, :name => 'Chips'), :diet => eat_anything, :stars_count => 2)
      eat_anything.popular_classifications.should == [pork_ribs_classification, chips_classification, steak_classification, cheese_pizza_classification, grilled_shrimp_classification]
    end
  end

  describe '#type' do
    it 'returns :inclusive for inclusive diets' do
      FactoryGirl.create(:diet, :exclusive => false).type.should == :inclusive
    end

    it 'returns :inclusive for inclusive diets' do
      FactoryGirl.create(:diet, :exclusive => true).type.should == :exclusive
    end
  end
end
