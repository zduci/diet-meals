require 'spec_helper'

describe Star do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:star).should be_valid
    end

    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:meal_id) }

    it { should validate_presence_of(:diet_id) }
  end

  context 'associations' do
    it { should belong_to(:diet) }

    it { should belong_to(:meal) }

    it { should belong_to(:user) }
  end
end
