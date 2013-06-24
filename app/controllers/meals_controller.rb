class MealsController < ApplicationController
  def new
    @meal = Meal.new_meal
    @foods = Food.all_names
    @hours = SelectOptions.hours
    @minutes = SelectOptions.minutes
    @units_of_measurement = UnitOfMeasurement.options_for_select
    @quantities = SelectOptions.quantities
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end

  def create
    meal = AddMeal.from_params(params[:meal])
    redirect_to meal_url(meal)
  rescue StandardError
    flash[:error] = 'There were errors. Meal was not saved'
    redirect_to :action => :new
  end
end
