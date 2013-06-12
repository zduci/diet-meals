require 'spec_helper'

describe HomeController do
  describe '#index' do
    it 'renders index' do
      get :index
      response.should render_template(:index)
    end
  end
end
