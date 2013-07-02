class StarsController < ApplicationController
  def create
    @meal_classification_id = params[:meal_diet_classification_id]
    @stars_count = AddStar.add(@meal_classification_id, current_user)

    if @stars_count
      render :formats => [:js]
    else
      render :nothing => true
    end
  end
end
