require 'spec_helper'

describe StarsController do
  describe '#create' do
    context 'user is logged in' do
      let(:classification_id) { '1' }
      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        sign_in user
      end

      def do_post
        post :create, :meal_diet_classification_id => classification_id
      end

      it 'tries to create a new star' do
        AddStar.should_receive(:add).with(classification_id, user)

        do_post
      end
      
      context 'creates a new star' do
        it 'returns the stars count' do
          stars_count = 1
          AddStar.stub(:add).with(classification_id, user) { stars_count }

          do_post
          response.body.should == "{\"stars_count\":#{stars_count}}"
        end
      end

      context 'fails to create a new star' do
        it 'returns the stars count' do
          AddStar.stub(:add).with(classification_id, user) { false }

          do_post
          response.body.should == "{}"
        end
      end
    end
  end
end
