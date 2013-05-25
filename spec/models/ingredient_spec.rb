require 'spec_helper'

describe Ingredient do
  let(:food) { FactoryGirl.create(:food) }
  let(:unit_of_measurement) { FactoryGirl.create(:unit_of_measurement) }
  let(:recipe) { FactoryGirl.create(:recipe) }

  it 'can create a valid object' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :recipe => recipe, :quantity => 1).should be_valid
  end

  it 'is invalid without a food' do
    FactoryGirl.build(:ingredient, :unit_of_measurement => unit_of_measurement, :recipe => recipe, :quantity => 1)
  end

  it 'is invalid without a recipe' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :quantity => 1)
  end

  it 'is invalid without a unit of measurement' do
    FactoryGirl.build(:ingredient, :food => food, :recipe => recipe, :quantity => 1)
  end

  it 'is invalid without a quantity' do
    FactoryGirl.build(:ingredient, :food => food, :unit_of_measurement => unit_of_measurement, :recipe => recipe)
  end
end
