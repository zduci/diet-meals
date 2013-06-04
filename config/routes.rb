DietMeals::Application.routes.draw do
  devise_for :admins

  devise_for :users

  root :to => 'home#index'

  resources :meals, :only => [:new, :show, :create]
end
