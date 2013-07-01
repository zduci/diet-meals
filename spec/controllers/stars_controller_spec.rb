require 'spec_helper'

describe StarsController do
  describe '#create' do
    context 'user is logged in' do
      it 'tries to create a new star' do
        classification_id = '1'
        user = FactoryGirl.create(:user)
        sign_in user

        AddStar.should_receive(:add).with(classification_id, user)

        post :create, :meal_diet_classification_id => classification_id
      end
      
      context 'creates a new star' do
        it 'returns the stars count' do
          classification_id = '1'
          user = FactoryGirl.create(:user)
          sign_in user
          stars_count = 1

          AddStar.stub(:add).with(classification_id, user) { stars_count }

          post :create, :meal_diet_classification_id => classification_id
          response.body.should == "{\"stars_count\":#{stars_count}}"
        end
      end
    end
  end
end
