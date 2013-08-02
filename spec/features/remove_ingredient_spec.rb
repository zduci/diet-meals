require 'spec_helper'

describe 'removing an ingredient' do
  include Warden::Test::Helpers
  before(:all) do
    Warden.test_mode!
  end

  after(:all) do
    Warden.test_reset!
  end

  before(:each) do
    login_as(FactoryGirl.create(:user), :scope => :user)
  end

  it 'removes an ingredient', :js => true do
    visit '/meals/new'
    
    initial_count = ingredients_count

    all('.remove_ingredient').first.click

    ingredients_count.should == initial_count - 1
  end

  def ingredients_count
    all('.ingredient').count
  end
end
