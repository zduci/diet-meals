class MealsController < ApplicationController
  def new
    @meal = Meal.new_meal
    @food_names = Food.all_names
    @hours = SelectOptions.hours
    @minutes = SelectOptions.minutes
    @units_of_measurement = UnitOfMeasurement.options_for_select
    @quantities = SelectOptions.quantity
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end

  def create
    meal = AddMeal.add(params[:meal][:name], params[:meal][:instructions], MealDuration.to_minutes(params[:meal][:duration_hours], params[:meal][:duration_minutes]), *params[:meal][:ingredients_attributes].values)
    redirect_to meal_url(meal)
  rescue StandardError
    flash[:error] = 'There were errors. Meal was not saved'
    redirect_to :action => :new
  end
end
