require 'spec_helper'
  include Devise::TestHelpers

describe 'starring a meal' do
  include Warden::Test::Helpers
  before(:all) do
    Warden.test_mode!
  end

  after(:all) do
    Warden.test_reset!
  end

  before(:each) do
    login_as(FactoryGirl.create(:user), :scope => :user)
    diet = FactoryGirl.create(:diet)
    @meal = FactoryGirl.create(:meal)
    @classification = FactoryGirl.create(:meal_diet_classification, :meal => @meal, :diet => diet)
  end

  it 'increments the stars count', :js => true do
    visit meal_path(@meal)

    click_link 'Star'

    find('.diet_classification').should have_content('1')
    find('.diet_classification').should have_content('Unstar')
  end
end
