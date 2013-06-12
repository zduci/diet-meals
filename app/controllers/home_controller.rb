class HomeController < ApplicationController
  def index
    @diets = Diet.popular
  end
end
