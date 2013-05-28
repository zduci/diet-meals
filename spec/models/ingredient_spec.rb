require 'spec_helper'

describe Ingredient do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:ingredient).should be_valid
    end

    it 'is invalid without a food' do
      FactoryGirl.build(:ingredient, :food => nil).should be_invalid
    end

    it 'is invalid without a meal' do
      FactoryGirl.build(:ingredient, :meal => nil).should be_invalid
    end

    it 'is invalid without a unit of measurement' do
      FactoryGirl.build(:ingredient, :unit_of_measurement => nil).should be_invalid
    end

    it 'is invalid without a quantity' do
      FactoryGirl.build(:ingredient, :quantity => nil).should be_invalid
    end

    it 'is invalid without a positive value greater than 0' do
      FactoryGirl.build(:ingredient, :quantity => 0).should be_invalid
    end
  end

  context 'alternative constructors' do
    it 'creates ingredients by meal, food, unit_of_measurement and quantity' do
      meal = stub(:meal)
      food = stub(:food)
      unit_of_measurement = stub(:unit_of_measurement)
      Ingredient.should_receive(:create!).with(:meal => meal, :food => food, :unit_of_measurement => unit_of_measurement, :quantity  => 1)
      Ingredient.create_ingredient(meal, food, unit_of_measurement, 1)
    end
  end
end
