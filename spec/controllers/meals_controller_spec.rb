require 'spec_helper'

describe MealsController do
  describe '#show' do
    it 'returns an empty meal' do
      meal = stub(:meal)
      Meal.stub(:new) { meal }
      get :new
      assigns['meal'].should == meal
    end
  end

end
