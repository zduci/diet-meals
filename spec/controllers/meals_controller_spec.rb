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
      SelectOptions.stub(:hours) { hours }
      SelectOptions.stub(:minutes) { minutes }
      SelectOptions.stub(:quantities) { quantities }
      get :new
    end

    it 'returns an empty meal' do
      assigns['meal'].should == meal
      assigns['hours'].should == hours
      assigns['minutes'].should == minutes
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
    let(:meal_params) { {} }

    def do_post
      post :create, :meal => meal_params
    end

    context 'success' do
      it "adds a new meal" do
        AddMeal.should_receive(:from_params).with(meal_params) { stub(:meal, :new_record? => false) }
        do_post
      end

      it "redirects to the new meal's url" do
        meal = stub(:meal, :new_record? => false)
        AddMeal.stub(:from_params).with(meal_params) { meal }
        do_post
        response.should redirect_to(meal_url(meal))
      end
    end

    context 'fail' do
      before(:each) do
        AddMeal.stub(:from_params).with(meal_params) { stub(:meal, :new_record? => true) } 
      end

      it 'displays error for invalid data' do
        do_post
        flash[:error].should_not be_nil
      end

      it 'redirects to new' do
        do_post
        response.should render_template(:new)
      end
    end
  end
end
