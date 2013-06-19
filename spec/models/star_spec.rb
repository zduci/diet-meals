require 'spec_helper'

describe Star do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:star).should be_valid
    end

    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:meal_id) }

    it { should validate_presence_of(:diet_id) }

    it 'validates uniqueness of diet_id, meal_id and user_id' do
      meal = FactoryGirl.create(:meal)
      diet = FactoryGirl.create(:diet)
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:star, :meal => meal, :diet => diet, :user => user)
      should validate_uniqueness_of(:user_id).scoped_to([:meal_id, :diet_id])
    end
  end

  context 'associations' do
    it { should belong_to(:diet) }

    it { should belong_to(:meal) }

    it { should belong_to(:user) }
  end
end
