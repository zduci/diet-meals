require 'spec_helper'

describe Recipe do
  it 'can create a valid instance' do
    FactoryGirl.build(:recipe, :instructions => 'Boil the egg', :name => 'Boiled egg').should be_valid
  end

  it 'is invalid without instructions' do
    FactoryGirl.build(:recipe, :name => 'Boiled egg').should be_invalid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:recipe, :instructions => 'Boil the egg').should be_invalid
  end

  it 'is invalid if the duration is less than 1' do
    FactoryGirl.build(:recipe, :instructions => 'Boil the egg', :name => 'Boiled egg', :duration => 0).should be_invalid
  end
end
