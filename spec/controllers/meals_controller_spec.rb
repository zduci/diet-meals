require 'spec_helper'

describe MealsController do
  let(:meal) { stub(:meal, :new_record? => true) }
  let(:foods) { stub(:foods) }
  let(:hours) { stub(:hours) }
  let(:minutes) { stub(:minutes) }
  let(:units_of_measurement) { stub(:units_of_measurement) }
  let(:quantities) { stub(:quantities) }
  let(:user) { FactoryGirl.create(:user) }

  describe '#new' do
    context 'user is signed in' do
      before(:each) do
        Meal.stub(:new_meal) { meal }
        SelectOptions.stub(:hours) { hours }
        SelectOptions.stub(:minutes) { minutes }
        SelectOptions.stub(:quantities) { quantities }
        Food.stub(:ordered_by_name) { foods }
        UnitOfMeasurement.stub(:ordered_by_name) { units_of_measurement }
        sign_in user
        get :new
      end

      it 'returns an empty meal' do
        assigns['meal'].should == meal
        assigns['hours'].should == hours
        assigns['minutes'].should == minutes
        assigns['quantities'].should == quantities
        assigns['foods'].should == foods
        assigns['units_of_measurement'].should == units_of_measurement
      end

      it 'renders new' do
        response.should render_template(:new)
      end
    end

    context 'user is not signed in' do
      it 'redirects to sign in' do
        get :new
        response.should redirect_to('/users/sign_in') 
      end
    end
  end

  describe '#show' do
    let(:id) { '1' }
    let(:meal) { stub(:meal) }

    context 'when meal exists' do
      before(:each) do
        Meal.stub(:find).with(id) { meal }
      end

      it 'fetches the requested meal' do
        get :show, :id => id
        assigns['meal'].should == meal
      end

      it 'renders show' do
        Meal.stub(:find).with(id) { meal }
        get :show, :id => id
        response.should render_template(:show)
      end
    end

    context 'when meal does not exist' do
      it 'redirects to root' do
        Meal.stub(:find).with(id).and_raise ActiveRecord::RecordNotFound
        get :show, :id => id
        response.should redirect_to(:root)
      end
    end
  end

  describe '#create' do
    let(:meal_params) { {} }
    let(:user) { FactoryGirl.create(:user) }

    def do_post
      post :create, :meal => meal_params
    end

    context 'user is signed in' do
      before(:each) do
        sign_in user
      end

      it "adds a new meal" do
        AddMeal.should_receive(:from_params).with(meal_params, user) { stub(:meal, :new_record? => false) }
        do_post
      end

      context 'success' do
        it "redirects to the new meal's url" do
          meal = stub(:meal, :new_record? => false)
          AddMeal.stub(:from_params).with(meal_params, user) { meal }
          do_post
          response.should redirect_to(meal_url(meal))
        end
      end

      context 'fail' do
        before(:each) do
          Meal.stub(:new_meal) { meal }
          SelectOptions.stub(:hours) { hours }
          SelectOptions.stub(:minutes) { minutes }
          SelectOptions.stub(:quantities) { quantities }
          Food.stub(:ordered_by_name) { foods }
          UnitOfMeasurement.stub(:ordered_by_name) { units_of_measurement }
          AddMeal.stub(:from_params).with(meal_params, user) { meal }
          do_post
        end

        it 'displays error for invalid data' do
          flash[:error].should_not be_nil
        end

        it 'redirects to new' do
          response.should render_template(:new)
        end

        it 'assigns instance variables' do
          assigns['meal'].should == meal
          assigns['hours'].should == hours
          assigns['minutes'].should == minutes
          assigns['quantities'].should == quantities
          assigns['foods'].should == foods
          assigns['units_of_measurement'].should == units_of_measurement
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
end
