require 'spec_helper'

describe StarsController do
  let(:user) { FactoryGirl.create(:user) }

  describe '#create' do
    let(:classification_id) { '1' }
    let(:stars_count) { 1 }
    let(:star) { stub(:star) }

    def do_post
      post :create, :meal_diet_classification_id => classification_id
    end

    context 'user is signed in' do
      before(:each) do
        sign_in user
      end
      
      context 'if it creates a new star' do
        before(:each) do
          Star.stub(:create_star).with(classification_id, user) { star }
          MealDietClassification.stub(:stars_count).with(classification_id) { stars_count }
          do_post
        end

        it 'renders the correct template' do
          response.should render_template(:create)
        end

        it 'assigns instance variables' do
          assigns['meal_classification_id'].should == classification_id
          assigns['stars_count'].should == stars_count
          assigns['star'].should == star
        end
      end

      context 'if it fails to create a new star' do
        it 'renders nothing' do
          Star.stub(:create_star).with(classification_id, user).and_raise ActiveRecord::RecordInvalid.new(Star.new)
          do_post
          response.body.should be_blank
        end
      end
    end

    context 'user is not signed in' do
      it 'redirects to sign in' do
        do_post
        response.should redirect_to('/users/sign_in') 
      end
    end
  end

  describe '#destroy' do
    let(:star_id) { '2' }
    let(:star) { stub(:star, :meal_diet_classification => stub(:reload => meal_classification))} 
    let(:meal_classification) { stub(:meal_diet_classification) }

    def do_delete
      delete :destroy, :id => star_id
    end

    context 'user is signed in' do
      before(:each) do
        sign_in user
      end

      it 'tries to delete a star' do
        Star.should_receive(:destroy).with(star_id) { star }
        do_delete
      end
      
      context 'deletes a star' do
        before(:each) do
          Star.stub(:destroy).with(star_id) { star }
          do_delete
        end

        it 'renders the correct template' do
          response.should render_template(:destroy)
        end

        it 'assigns instance variables' do
          assigns['meal_classification'].should == meal_classification
        end
      end

      context 'fails to delete a star' do
        it 'renders nothing' do
          Star.stub(:destroy).with(star_id) { raise ActiveRecord::RecordNotFound }
          do_delete
          response.body.should be_blank
        end
      end
    end

    context 'user is not signed in' do
      it 'redirects to sign in' do
        do_delete
        response.should redirect_to('/users/sign_in') 
      end
    end
  end
end
