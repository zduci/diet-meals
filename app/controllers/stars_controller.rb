class StarsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @meal_classification_id = params[:meal_diet_classification_id]
    @star = Star.create_star(@meal_classification_id, current_user)
    @stars_count = MealDietClassification.stars_count(@meal_classification_id)
    render :formats => [:js]
  rescue ActiveRecord::RecordInvalid
    render :nothing => true
  end

  def destroy
    star = Star.destroy(params[:id])
    @meal_classification = star.meal_diet_classification.reload
    render :formats => [:js]
  rescue ActiveRecord::RecordNotFound => e
    render :nothing => true
  end
end
