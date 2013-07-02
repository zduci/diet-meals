require 'spec_helper'
  include Devise::TestHelpers

describe 'starring a meal' do
  include Warden::Test::Helpers
  Warden.test_mode!

  before(:each) do
    login_as(FactoryGirl.create(:user), :scope => :user)
    diet = FactoryGirl.create(:diet)
    @meal = FactoryGirl.create(:meal)
    @classification = FactoryGirl.create(:meal_diet_classification, :meal => @meal, :diet => diet)
  end

  after(:each) do
    Warden.test_reset!
  end

  it 'increments the stars count', :js => true do
    visit meal_path(@meal)

    click_link 'Star'

    find('.diet_classification').text.should include('1')
  end
end
