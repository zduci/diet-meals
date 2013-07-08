class StarsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @meal_classification_id = params[:meal_diet_classification_id]
    @stars_count = StarRepository.add(@meal_classification_id, current_user)

    if @stars_count
      @star_id = Star.find_star(@meal_classification_id, current_user)
      render :formats => [:js]
    else
      render :nothing => true
    end
  end

  def destroy
    star = Star.destroy(params[:id])
    meal_classification = star.meal_diet_classification.reload
    @stars_count = meal_classification.stars_count
    @meal_classification_id = meal_classification.id
    render :formats => [:js]
  rescue ActiveRecord::RecordNotFound => e
    render :nothing => true
  end
end
