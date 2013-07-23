require 'spec_helper'

describe User do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:user).should be_valid
    end

    it { should have_many(:meals) }

    it { should have_many(:stars) }
  end

  describe '::name' do
    it 'extracts an username from the email address' do
      bob = FactoryGirl.build(:user, :email => 'bob@example.com')
      bob.name.should == 'bob'
    end
  end
end
