class StarsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @meal_classification_id = params[:meal_diet_classification_id]
    @stars_count = StarRepository.add(@meal_classification_id, current_user)

    if @stars_count
      render :formats => [:js]
    else
      render :nothing => true
    end
  end
end
