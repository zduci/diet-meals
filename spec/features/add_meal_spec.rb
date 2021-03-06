require 'spec_helper'

describe 'adding a meal' do
  include Warden::Test::Helpers
  before(:all) do
    Warden.test_mode!
  end

  after(:all) do
    Warden.test_reset!
  end

  before(:each) do
    login_as(FactoryGirl.create(:user), :scope => :user)
    egg = FactoryGirl.create(:food, :name => :egg)
    salt = FactoryGirl.create(:food, :name => :salt)
    FactoryGirl.create(:unit_of_measurement, :name => 'gram', :short_name => 'g')
    allows_eggs = FactoryGirl.create(:diet, :name => 'allows eggs', :exclusive => true) 
    FactoryGirl.create(:diet_food_connection, :diet => allows_eggs, :food => egg, :allowed => true) 
    FactoryGirl.create(:diet_food_connection, :diet => allows_eggs, :food => salt, :allowed => true) 
    no_eggs = FactoryGirl.create(:diet, :name => 'do not eat eggs', :exclusive => false) 
    FactoryGirl.create(:diet_food_connection, :diet => no_eggs, :food => egg, :allowed => false)
  end

  it 'creates a new meals and classifies it into the correct diets' do
    visit '/meals/new'
    fill_in 'meal_name', :with => 'boiled eggs'
    fill_in 'meal_instructions', :with => 'boil the eggs, add salt'
    select '0', :from => 'meal_duration_hours'
    select '5', :from => 'meal_duration_minutes'

    select :egg, :from => 'meal_ingredients_attributes_0_food_id'
    select '2', :from => 'meal_ingredients_attributes_0_quantity'

    select :salt, :from => 'meal_ingredients_attributes_1_food_id'
    select 'gram', :from => 'meal_ingredients_attributes_1_unit_of_measurement_id'
    select '2', :from => 'meal_ingredients_attributes_1_quantity'
    
    click_button 'Create meal'

    page.should have_content 'allows eggs'
    page.should_not have_content 'do not eat eggs'
  end
end
