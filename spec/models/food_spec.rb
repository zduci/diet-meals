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

  context 'constructors' do
    it 'creates an instance by name' do
      avocado = Food.create_food('avocado')
      Food.find_by_name('avocado').should == avocado
    end
  end

  context 'queries' do
    it 'returns the names of all foods' do
      FactoryGirl.create(:food, :name => 'avocado')
      FactoryGirl.create(:food, :name => 'peanut')
      FactoryGirl.create(:food, :name => 'melon')
      Food.all_names.should =~ ['avocado', 'peanut', 'melon']
    end
  end
end
