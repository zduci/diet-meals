require 'spec_helper'

describe MealsController do
  describe '#new' do
    let(:meal) { stub(:meal) }

    before(:each) do
      Meal.stub(:new) { meal }
      get :new
    end

    it 'returns an empty meal' do
      assigns['meal'].should == meal
    end

    it 'renders new' do
      response.should render_template(:new)
    end
  end

  describe '#show' do
    it 'returns the requested meal' do
      id = '1'
      meal = stub(:meal)
      Meal.stub(:find_by_id).with(id) { meal }
      get :show, :id => id
      assigns['meal'].should == meal
    end
  end

  describe '#create' do
    let(:meal) { stub(:meal) }
    let(:name) { 'toast' }
    let(:instructions) { 'toast the bread' }
    let(:duration) { '3' }
    let(:ingredient) { {'name' => 'bread', 'quantity' => '2', 'unit_of_measurement' => 'slices'} }

    def do_post
      post :create, :meal => { :name => name,
                    :instructions => instructions,
                    :duration => duration,
                    :ingredients => {'0' => ingredient} }
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
