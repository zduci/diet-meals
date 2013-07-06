require 'spec_helper'

describe Star do
  let(:classification) { FactoryGirl.create(:meal_diet_classification) }
  let(:user) { FactoryGirl.create(:user) }

  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:star).should be_valid
    end

    it { should validate_presence_of(:user_id) }

    it { should validate_presence_of(:meal_diet_classification_id) }

    it 'validates uniqueness of diet_id, meal_id and user_id' do
      FactoryGirl.create(:star, :meal_diet_classification => classification, :user => user)
      should validate_uniqueness_of(:user_id).scoped_to([:meal_diet_classification_id])
    end
  end

  context 'associations' do
    it { should belong_to(:meal_diet_classification) }

    it { should have_one(:meal) }

    it { should have_one(:diet) }

    it { should belong_to(:user) }
  end

  context 'adding a new star' do
    it 'updates stars_count on MealDietClassification' do
      classification = FactoryGirl.create(:meal_diet_classification, :stars_count => 0)
      FactoryGirl.create(:star, :user => FactoryGirl.create(:user), :meal_diet_classification => classification)
      classification.reload.stars_count.should == 1
    end
  end

  context 'constructors' do
    describe 'Star#create_star' do
      context 'star does not exist' do
        it 'creates a new star by meal diet classification id and user' do
          Star.find_by_meal_diet_classification_id_and_user_id(classification.id, user.id)
        end
      end

      context 'star already exists' do
        it 'returns false' do
          FactoryGirl.create(:star, :meal_diet_classification => classification, :user => user)
          Star.create_star(classification.id, user).should == false
        end
      end
    end
  end

  describe 'Star#delete_star' do
    context 'star exists' do
      it 'deletes the star by meal diet classification id and user' do
        FactoryGirl.create(:star, :meal_diet_classification => classification, :user => user)

        Star.delete_star(classification.id, user)
        Star.find_by_meal_diet_classification_id_and_user_id(classification, user).should be_nil
      end

      it 'return true' do
        FactoryGirl.create(:star, :meal_diet_classification => classification, :user => user)

        Star.delete_star(classification.id, user).should be_true
      end
    end

    context 'star does not exist' do
      it 'returns false' do
        Star.delete_star(classification.id, user).should be_false
      end
    end
  end
end
