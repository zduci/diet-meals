require 'spec_helper'

describe 'adding a meal' do
  before(:each) do
    @egg = FactoryGirl.create(:food, :name => :egg)
    @salt = FactoryGirl.create(:food, :name => :salt)
    gram = FactoryGirl.create(:unit_of_measurement, :name => 'gram', :short_name => 'g')
    @allows_eggs = FactoryGirl.create(:diet, :name => 'allows eggs', :exclusive => true, :allowed_foods => [@egg, @salt])
    allows_nothing = FactoryGirl.create(:diet, :name => 'do not eat', :exclusive => true)
  end

  it 'can create meals' do
    visit '/meals/new'
    fill_in 'name', :with => 'boiled eggs'
    fill_in 'instructions', :with => 'boil the eggs, add salt'
    fill_in 'duration', :with => 5
    fill_in 'food_1', :with => 'egg'
    fill_in 'quantity_1', :with => 2
    fill_in 'food_2', :with => 'egg'
    fill_in 'unit_of_measurement_2', :with => 'g'
    fill_in 'quantity_2', :with => 2
    
    click_button 'add_meal'

    page.should have_content 'allows eggs'
  end
end
