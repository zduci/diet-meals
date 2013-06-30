class StarsController < ApplicationController
  def create
    Star.create_star(params[:meal_diet_classification_id], current_user)
    render :json => ''
  end
end
