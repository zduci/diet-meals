class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end

  def create
    @meal = AddMeal.add(params[:name], params[:instructions], params[:duration], *params[:ingredients])
    render :show
  end
end
