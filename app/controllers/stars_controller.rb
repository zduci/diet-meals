class StarsController < ApplicationController
  def create
    AddStar.add(params[:meal_diet_classification_id], current_user)
    render :json => ''
  end
end
