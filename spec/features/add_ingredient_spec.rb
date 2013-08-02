require 'spec_helper'

describe 'adding an ingredient' do
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

  it 'adds a new ingredient', :js => true do
    visit '/meals/new'
    
    initial_count = ingredients_count

    find('#add_ingredient').click

    ingredients_count.should == initial_count + 1
  end

  def ingredients_count
    all('.ingredient').count
  end
end
