require 'spec_helper'

describe DietsController do
  describe '#show' do
    let(:id) { '1' }
    let(:diet) { double(:diet) }

    before(:each) do
      Diet.stub(:find_by_id).with(id) { diet }
      get :show, :id => id
    end

    it 'fetches the requested meal' do
      assigns['diet'].should == diet
    end

    it 'renders show' do
      response.should render_template(:show)
    end
  end
end
