require 'spec_helper'

describe MealsController do
  describe '#new' do
    let(:meal) { stub(:meal) }
    let(:foods) { stub(:foods) }
    let(:hours) { stub(:hours) }
    let(:minutes) { stub(:minutes) }
    let(:units_of_measurement) { stub(:units_of_measurement) }
    let(:quantities) { stub(:quantities) }

    before(:each) do
      Meal.stub(:new_meal) { meal }
      Food.stub(:all_names) { foods }
      SelectOptions.stub(:hours) { hours }
      SelectOptions.stub(:minutes) { minutes }
      UnitOfMeasurement.stub(:options_for_select) { units_of_measurement }
      SelectOptions.stub(:quantities) { quantities }
      get :new
    end

    it 'returns an empty meal' do
      assigns['meal'].should == meal
      assigns['foods'].should == foods
      assigns['hours'].should == hours
      assigns['minutes'].should == minutes
      assigns['units_of_measurement'].should == units_of_measurement
      assigns['quantities'].should == quantities
    end

    it 'renders new' do
      response.should render_template(:new)
    end
  end

  describe '#show' do
    let(:id) { '1' }
    let(:meal) { stub(:meal) }

    before(:each) do
      Meal.stub(:find_by_id).with(id) { meal }
      get :show, :id => id
    end

    it 'fetches the requested meal' do
      assigns['meal'].should == meal
    end

    it 'renders show' do
      response.should render_template(:show)
    end
  end

  describe '#create' do
    let(:meal) { stub(:meal) }
    let(:meal_params) { {} }

    def do_post
      post :create, :meal => meal_params
    end

    context 'success' do
      it "adds a new meal" do
        AddMeal.should_receive(:from_params).with(meal_params)
        do_post
      end

      it "redirects to the new meal's url" do
        AddMeal.stub(:from_params).with(meal_params) { meal }
        do_post
        response.should redirect_to(meal_url(meal))
      end
    end

    context 'fail' do
      before(:each) { AddMeal.stub(:from_params).and_raise(StandardError.new) }
      it 'displays error for invalid data' do
        do_post
        flash[:error].should_not be_nil
      end

      it 'redirects to new' do
        do_post
        response.should redirect_to(:action => :new)
      end
    end
  end
end
