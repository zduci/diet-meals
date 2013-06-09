require 'spec_helper'

describe MealsController do
  describe '#new' do
    it 'returns an empty meal' do
      meal = stub(:meal)
      Meal.stub(:new) { meal }
      get :new
      assigns['meal'].should == meal
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

    it 'adds a new meal' do
      AddMeal.stub(:add).with(name, instructions, duration, ingredient) { meal }
      post :create, :meal => { :name => name,
                    :instructions => instructions,
                    :duration => duration,
                    :ingredients => {'0' => ingredient} }
      response.should redirect_to(meal_url(meal))
    end
    end
  end

end
