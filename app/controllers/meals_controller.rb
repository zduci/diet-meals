class MealsController < ApplicationController
  def new
    @meal = Meal.new_meal
    @hours = SelectOptions.hours
    @minutes = SelectOptions.minutes
    @quantities = SelectOptions.quantities
    @units_of_measurement = UnitOfMeasurement.all
    @foods = Food.all
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end

  def create
    @meal = AddMeal.from_params(params[:meal])
    unless @meal.new_record?
      redirect_to meal_url(@meal)
    else 
      @hours = SelectOptions.hours
      @minutes = SelectOptions.minutes
      @quantities = SelectOptions.quantities
      flash[:error] = 'There were errors. Meal was not saved'
      render :action => :new
    end
  end
end
