class StarsController < ApplicationController
  def create
    stars_count = AddStar.add(params[:meal_diet_classification_id], current_user)
    render :json => {:stars_count => stars_count}
  end
end
