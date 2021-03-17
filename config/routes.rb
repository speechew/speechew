Rails.application.routes.draw do
  devise_for :users
  get 'speak-now', to: 'speak_now#index'
  get 'dashboard/index'
  root "speak_now#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
