class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end

  def create
    @meal = AddMeal.add(params[:meal][:name], params[:meal][:instructions], params[:meal][:duration], *params[:meal][:ingredients].values)
    render :show
  end
end
