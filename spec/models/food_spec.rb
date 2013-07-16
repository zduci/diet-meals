require 'spec_helper'

describe Food do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:food).should be_valid
    end

    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name) }
  end

  context 'associations' do
    it { should have_many(:parent_foods) }

    it { should have_many(:child_foods) }

    it { should have_many(:ingredients) }
  end

  describe '::create_food' do
    it 'creates an instance by name' do
      avocado = Food.create_food('avocado')
      Food.find_by_name('avocado').should == avocado
    end
  end

  describe '::ordered_by_name' do
    it 'retrieves all foods ordered by name' do
      orange = FactoryGirl.create(:food, :name => 'orange')
      apple = FactoryGirl.create(:food, :name => 'apple')
      banana = FactoryGirl.create(:food, :name => 'banana')
      Food.ordered_by_name.should == [apple, banana, orange]
    end
  end
end
