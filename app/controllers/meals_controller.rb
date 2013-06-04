class MealsController < ApplicationController
  def new
    @meal = Meal.new
  end
end
