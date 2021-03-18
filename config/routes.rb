Rails.application.routes.draw do
  resources :question_sets
  resources :topics
  resources :countries
  resources :languages
  devise_for :users, :controllers => {:registrations => "user/registrations"}
  get 'speak-now', to: 'speak_now#index'
  get 'dashboard', to: 'dashboard#index'
  root "speak_now#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
