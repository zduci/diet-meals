require 'spec_helper'

describe HomeController do
  describe '#index' do
    let(:diets) { double(:diets) }

    before(:each) do
      Diet.stub(:popular) { diets }
      get :index
    end

    it 'renders index' do
      response.should render_template(:index)
    end

    it 'fetches the most popular diets' do
      assigns['diets'].should == diets
    end
  end
end
