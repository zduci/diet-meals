require 'spec_helper'

describe Food do
  it 'can create a valid object' do
    FactoryGirl.build(:food).should be_valid
  end

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name) }

  it 'creates an instance by name' do
    Food.should_receive(:create!).with(:name => 'avocado')
    Food.create_food('avocado')
  end
end
