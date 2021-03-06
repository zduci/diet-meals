require 'spec_helper'
include Devise::TestHelpers
include Warden::Test::Helpers

describe 'starring meal classifications' do
  before(:all) do
    Warden.test_mode!
  end

  after(:all) do
    Warden.test_reset!
  end

  let(:diet) { FactoryGirl.create(:diet) }
  let(:meal) { FactoryGirl.create(:meal) }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    FactoryGirl.create(:meal_diet_classification, :meal => meal, :diet => diet)
  end

  context 'user is signed in' do
    before(:each) do
      login_as(user, :scope => :user)
    end

    it 'starring a meal increments the stars count', :js => true do
      visit meal_path(meal)

      click_link 'Star'

      find('.diet_classification').should have_content('1')
      find('.diet_classification').should have_content('Unstar')
    end

    it 'unstarring a meal decrements the stars count', :js => true do
      FactoryGirl.create(:star, :user => user)
      visit meal_path(meal)

      click_link 'Unstar'

      find('.diet_classification').should have_content('0')
      find('.diet_classification').should have_content('Star')
    end
  end

  context 'user is not signed in' do
    it 'user cannot star or unstar' do
      visit meal_path(meal)

      page.should_not have_content('Star')
      page.should_not have_content('Unstar')
    end
  end
end
