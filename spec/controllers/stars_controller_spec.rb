require 'spec_helper'

describe StarsController do
  describe '#create' do
    context 'user is logged in' do
      it 'tries to create a new star' do
        classification_id = '1'
        user = FactoryGirl.create(:user)
        sign_in user

        Star.should_receive(:create_star).with(classification_id, user)

        post :create, :meal_diet_classification_id => classification_id
      end
    end
  end
end
