require 'spec_helper'

describe Ingredient do
  let(:food) { FactoryGirl.create(:egg) }
  let(:unit_of_measurement) { FactoryGirl.create(:gram) }
  let(:recipe) { FactoryGirl.create(:boiled_egg) }

  it 'can create a valid object' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :recipe => recipe, :quantity => 1).should be_valid
  end

  it 'is invalid without a food' do
    FactoryGirl.build(:ingredient, :unit_of_measurement => unit_of_measurement, :recipe => recipe, :quantity => 1).should be_invalid
  end

  it 'is invalid without a recipe' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :quantity => 1).should be_invalid
  end

  it 'is invalid without a unit of measurement' do
    FactoryGirl.build(:ingredient, :food => food, :recipe => recipe, :quantity => 1).should be_invalid
  end

  it 'is invalid without a quantity' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :recipe => recipe).should be_invalid
  end

  it 'is invalid without a positive value greater than 0' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :recipe => recipe, :quantity => 0).should be_invalid
  end
end
