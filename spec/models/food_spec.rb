require 'spec_helper'

describe Food do
  let(:food) { FactoryGirl.build(:food) }

  it 'can create a valid object' do
    food.should be_valid
  end

  it { food.should validate_presence_of(:name) }

  it { food.should validate_uniqueness_of(:name) }

  it 'creates an instance by name' do
    Food.should_receive(:create!).with(:name => 'avocado')
    Food.create_food('avocado')
  end
end
