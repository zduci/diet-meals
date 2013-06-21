class MealsController < ApplicationController
  def new
    @meal = Meal.new_meal
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end

  def create
    meal = AddMeal.add(params[:meal][:name], params[:meal][:instructions], params[:meal][:duration], *params[:meal][:ingredients_attributes].values)
    redirect_to meal_url(meal)
  rescue StandardError
    flash[:error] = 'There were errors. Meal was not saved'
    redirect_to :action => :new
  end
end
