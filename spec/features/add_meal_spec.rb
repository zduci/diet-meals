require 'spec_helper'

describe 'adding a meal' do
  before(:each) do
    @egg = FactoryGirl.create(:food, :name => :egg)
    @salt = FactoryGirl.create(:food, :name => :salt)
    FactoryGirl.create(:unit_of_measurement, :name => 'gram', :short_name => 'g')
    @allows_eggs = FactoryGirl.create(:diet, :name => 'allows eggs', :exclusive => true, :allowed_foods => [@egg, @salt])
    FactoryGirl.create(:diet, :name => 'do not eat eggs', :exclusive => false, :forbidden_foods => [@egg])
  end

  it 'can create meals' do
    visit '/meals/new'
    fill_in 'meal_name', :with => 'boiled eggs'
    fill_in 'meal_instructions', :with => 'boil the eggs, add salt'
    select '0', :from => 'meal_duration_hours'
    select '5', :from => 'meal_duration_minutes'

    fill_in 'meal_ingredients_attributes_0_food_name', :with => 'egg'
    fill_in 'meal_ingredients_attributes_0_quantity', :with => 2

    fill_in 'meal_ingredients_attributes_1_food_name', :with => 'salt'
    select 'g', :from => 'meal_ingredients_attributes_1_unit_of_measurement_short_name'
    fill_in 'meal_ingredients_attributes_1_quantity', :with => 2
    
    click_button 'Add Meal'

    page.should have_content 'allows eggs'
    page.should_not have_content 'do not eat eggs'
  end
end
