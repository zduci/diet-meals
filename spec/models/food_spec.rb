require 'spec_helper'

describe Food do
  it 'can create a valid object' do
    FactoryGirl.build(:food, :name => 'avocado').should be_valid
  end

  it 'is invalid without a name' do
    FactoryGirl.build(:food).should be_invalid
  end
end
