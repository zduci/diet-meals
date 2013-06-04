class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end

  def show
    @meal = Meal.find_by_id(params[:id])
  end
end
