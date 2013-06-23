require 'spec_helper'

describe MealsController do
  describe '#new' do
    let(:meal) { stub(:meal) }
    let(:food_names) { stub(:food_names) }
    let(:hours) { stub(:hours) }
    let(:minutes) { stub(:minutes) }
    let(:units_of_measurement) { stub(:units_of_measurement) }
    let(:quantities) { stub(:quantities) }

    before(:each) do
      Meal.stub(:new_meal) { meal }
      Food.stub(:all_names) { food_names }
      SelectOptions.stub(:hours) { hours }
      SelectOptions.stub(:minutes) { minutes }
      UnitOfMeasurement.stub(:options_for_select) { units_of_measurement }
      SelectOptions.stub(:quantity) { quantities }
      get :new
    end

    it 'returns an empty meal' do
      assigns['meal'].should == meal
      assigns['food_names'].should == food_names
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
    let(:name) { 'toast' }
    let(:instructions) { 'toast the bread' }
    let(:duration) { '3' }
    let(:duration_hours) { '0' }
    let(:duration_minutes) { '3' }
    let(:ingredient) { {'food' => { 'name' => 'bread' }, 'quantity' => '2', 'unit_of_measurement' => { 'short_name' => 'slices'} }}

    before(:each) do
      MealDuration.stub(:to_minutes).with(duration_hours, duration_minutes) { duration }
    end

    def do_post
      post :create, :meal => { :name => name,
                    :instructions => instructions,
                    :duration_hours => duration_hours,
                    :duration_minutes => duration_minutes,
                    :ingredients_attributes => {'0' => ingredient} }
    end

    context 'success' do
      it "adds a new meal" do
        AddMeal.should_receive(:add).with(name, instructions, duration, ingredient) { meal }
        do_post
      end

      it "redirects to the new meal's url" do
        AddMeal.stub(:add).with(name, instructions, duration, ingredient) { meal }
        do_post
        response.should redirect_to(meal_url(meal))
      end
    end

    context 'fail' do
      before(:each) { AddMeal.stub(:add).and_raise(StandardError.new) }
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
