require 'spec_helper'

describe MealsController do
  let(:meal) { stub(:meal, :new_record? => true) }
  let(:foods) { stub(:foods) }
  let(:units_of_measurement) { stub(:units_of_measurement) }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    Food.stub(:ordered_by_name) { foods }
    UnitOfMeasurement.stub(:ordered_by_name) { units_of_measurement }
  end

  describe '#new' do
    context 'user is signed in' do
      before(:each) do
        Meal.stub(:new_meal) { meal }
        sign_in user
        get :new
      end

      it 'returns an empty meal with all the instance variables needed for meal creation' do
        assigns['meal'].should == meal
        assigns['hours'].should == SelectOptions::HOURS
        assigns['minutes'].should == SelectOptions::MINUTES
        assigns['quantities'].should == SelectOptions::QUANTITIES
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

      context 'when it creates new meal' do
        it "redirects to the new meal's url" do
          meal = stub(:meal, :new_record? => false)
          AddMeal.stub(:from_params).with(meal_params, user) { meal }
          do_post
          response.should redirect_to(meal_url(meal))
        end
      end

      context 'when it fails to create new meal' do
        before(:each) do
          AddMeal.stub(:from_params).with(meal_params, user) { meal }
          do_post
        end

        it 'contains errors' do
          flash[:error].should_not be_nil
        end

        it 'renders new' do
          response.should render_template(:new)
        end

        it 'assigns instance variables' do
          assigns['meal'].should == meal
          assigns['hours'].should == SelectOptions::HOURS
          assigns['minutes'].should == SelectOptions::MINUTES
          assigns['quantities'].should == SelectOptions::QUANTITIES
          assigns['foods'].should == foods
          assigns['units_of_measurement'].should == units_of_measurement
        end
      end
    end

    context 'user is not signed in' do
      it 'redirects to sign in page' do
        do_post
        response.should redirect_to('/users/sign_in') 
      end
    end
  end
end
