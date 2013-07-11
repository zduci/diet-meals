class MealsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def new
    @meal = Meal.new_meal
    @hours = SelectOptions.hours
    @minutes = SelectOptions.minutes
    @quantities = SelectOptions.quantities
    @units_of_measurement = UnitOfMeasurement.ordered_by_name
    @foods = Food.ordered_by_name
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = AddMeal.from_params(params[:meal], current_user)
    unless @meal.new_record?
      redirect_to meal_url(@meal)
    else 
      @hours = SelectOptions.hours
      @minutes = SelectOptions.minutes
      @quantities = SelectOptions.quantities
      @units_of_measurement = UnitOfMeasurement.ordered_by_name
      @foods = Food.ordered_by_name
      flash[:error] = 'There were errors. Meal was not saved'
      render :action => :new
    end
  end
end
