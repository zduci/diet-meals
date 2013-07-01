class StarsController < ApplicationController
  def create
    stars_count = AddStar.add(params[:meal_diet_classification_id], current_user)
    if stars_count
      render :json => {:stars_count => stars_count}
    else
      render :json => {}
    end
  end
end
