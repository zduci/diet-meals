require 'spec_helper'

describe User do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:user).should be_valid
    end

    it { should have_many(:meals) }
  end
end
