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
    fill_in 'meal_name', :with => 'boiled eggs'
    fill_in 'meal_instructions', :with => 'boil the eggs, add salt'
    fill_in 'meal_duration', :with => 5
    fill_in 'meal_ingredients_0_name', :with => 'egg'
    fill_in 'meal_ingredients_0_quantity', :with => 2
    fill_in 'meal_ingredients_1_name', :with => 'salt'
    fill_in 'meal_ingredients_1_unit_of_measurement', :with => 'g'
    fill_in 'meal_ingredients_1_quantity', :with => 2
    
    click_button 'Add Meal'

    page.should have_content 'allows eggs'
  end
end
