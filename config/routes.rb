Rails.application.routes.draw do
  get 'give-feedback', to: 'give_feedback#index'
  get 'suggestion-panel', to: 'suggestion_panel#index'
  get 'ask-doubt', to: 'ask_doubt#index'
  resources :rooms
  get 'user-guides', to: 'user_guides#index'
  get 'user-settings', to: 'user_settings#index'
  resources :articles
  resources :categories
  get 'my-articles', to: 'articles#my_articles'
  get 'review-articles', to: 'articles#review_articles'
  get 'users-list', to: 'users_list#index'
  get 'user-view/:id', to: 'users#user_view', :as => :user_view
  resources :knowledge_books, :path => 'knowledge-books'
  resources :pages
  resources :question_sets, :path => 'question-sets'
  resources :topics
  resources :countries
  resources :languages
  devise_for :users, :controllers => {:registrations => "user/registrations"}
  get 'speak-now', to: 'speak_now#index'
  get 'dashboard', to: 'dashboard#index'
  root "speak_now#index"
  get "start_speaking", to: 'rooms#create_room'
  get "search_partner", to: 'rooms#search_partner'
  get "decline-call", to: 'rooms#decline_call'
  get "free-user", to: 'rooms#free_user'
  resources :conversations, only: [:create] do
    member do
      post :close
    end
  end
  resources :messages, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
