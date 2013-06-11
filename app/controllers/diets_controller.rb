class DietsController < ApplicationController
  def show
    @diet = Diet.find_by_id(params[:id])
  end
end
