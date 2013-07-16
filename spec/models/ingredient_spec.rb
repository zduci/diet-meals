require 'spec_helper'

describe Ingredient do
  context 'validations' do
    it 'can create a valid object' do
      FactoryGirl.build(:ingredient).should be_valid
    end

    it { should validate_presence_of(:food_id) }

    it { should validate_presence_of(:quantity) }

    it 'is invalid without a positive value greater than 0' do
      FactoryGirl.build(:ingredient, :quantity => 0).should be_invalid
    end
  end

  context 'associations' do
    it { should belong_to(:food) }

    it { should belong_to(:unit_of_measurement) }

    it { should belong_to(:meal) }
  end

  context '#unit_of_measurement' do
    it 'returns unit of measurement if different to nil' do
      unit_of_measurement = FactoryGirl.build(:unit_of_measurement)
      FactoryGirl.build(:ingredient, :unit_of_measurement => unit_of_measurement).unit_of_measurement.should == unit_of_measurement
    end

    it 'returns UnitOfMeasurement::PIECE if unit of measurement is nil' do
      FactoryGirl.build(:ingredient, :unit_of_measurement => nil).unit_of_measurement.should == UnitOfMeasurement::PIECE
    end
  end

  context '::create_ingredient' do
    let(:meal) { FactoryGirl.create(:meal) }
    let(:food) { FactoryGirl.create(:food) }
    let(:unit_of_measurement) { FactoryGirl.create(:unit_of_measurement) }

    it 'creates ingredients by meal, food and quantity' do
      ingredient = Ingredient.create_ingredient(meal, food, 1)
      Ingredient.find_by_meal_id_and_food_id_and_quantity(meal, food, 1).should == ingredient
    end

    it 'creates ingredients by meal, food, quantity and unit_of_measurement' do
      ingredient = Ingredient.create_ingredient(meal, food, 1, unit_of_measurement)
      Ingredient.find_by_meal_id_and_food_id_and_quantity_and_unit_of_measurement_id(meal, food, 1, unit_of_measurement).should == ingredient
    end
  end
end
