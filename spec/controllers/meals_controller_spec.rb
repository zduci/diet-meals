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
end
