require 'spec_helper'

describe DietClassification do
  it 'can create a valid instance' do
    FactoryGirl.build(:diet_classification).should be_valid
  end
end
