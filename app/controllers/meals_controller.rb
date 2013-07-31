class MealsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def new
    @meal = Meal.new_meal
    instantiate_instance_variables
  end

  def show
    @meal = Meal.find(params[:id])
  end

  def create
    @meal = AddMeal.from_params(meal_params, current_user)
    unless @meal.new_record?
      redirect_to meal_url(@meal)
    else 
      instantiate_instance_variables
      flash[:error] = 'There were errors. Meal was not saved'
      render :action => :new
    end
  end

  def instantiate_instance_variables
    @units_of_measurement = UnitOfMeasurement.ordered_by_name
    @foods = Food.ordered_by_name
  end

  def meal_params
    params.require(:meal).permit(:duration, :instructions, :ingredients, :name, :user_id, :duration_hours, :duration_minutes, :ingredients_attributes => [:food_id, :quantity, :unit_of_measurement_id])
  end
end
