DietMeals::Application.routes.draw do
  devise_for :admins

  devise_for :users

  root :to => 'home#index'

  get 'meals/new' => 'meals#new'
end
