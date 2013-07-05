require 'spec_helper'

describe StarsController do
  describe '#create' do
    let(:classification_id) { '1' }
    def do_post
      post :create, :meal_diet_classification_id => classification_id
    end

    context 'user is signed in' do
      let(:user) { FactoryGirl.create(:user) }

      before(:each) do
        sign_in user
      end

      it 'tries to create a new star' do
        StarRepository.should_receive(:add).with(classification_id, user)
        do_post
      end
      
      context 'creates a new star' do
        let(:stars_count) { 1 }

        before(:each) do
          StarRepository.stub(:add).with(classification_id, user) { stars_count }
          do_post
        end

        it 'renders the correct template' do
          response.should render_template(:create)
        end

        it 'assigns instance variables' do
          assigns['meal_classification_id'].should == classification_id
          assigns['stars_count'].should == stars_count
        end
      end

      context 'fails to create a new star' do
        it 'renders nothing' do
          StarRepository.stub(:add).with(classification_id, user) { false }

          do_post
          response.body.should be_blank
        end
      end
    end

    context 'user is not signed in' do
      it 'redirects to sign in' do
        do_post
        response.code.should redirect_to('/users/sign_in') 
      end
    end
  end
end
