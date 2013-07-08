require 'spec_helper'
include Devise::TestHelpers
include Warden::Test::Helpers

describe 'meal classification stars' do
  before(:all) do
    Warden.test_mode!
  end

  after(:all) do
    Warden.test_reset!
  end

  before(:each) do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    diet = FactoryGirl.create(:diet)
    @meal = FactoryGirl.create(:meal)
    @classification = FactoryGirl.create(:meal_diet_classification, :meal => @meal, :diet => diet)
  end

  it 'starring a meal increments the stars count', :js => true do
    visit meal_path(@meal)

    click_link 'Star'

    find('.diet_classification').should have_content('1')
    find('.diet_classification').should have_content('Unstar')
  end

  it 'unstarring a meal decrements the stars count', :js => true do
    FactoryGirl.create(:star, :user => @user)
    visit meal_path(@meal)

    click_link 'Unstar'

    find('.diet_classification').should have_content('0')
    find('.diet_classification').should have_content('Star')
  end
end
