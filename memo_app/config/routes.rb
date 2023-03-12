Rails.application.routes.draw do
  resources :memos
  root 'welcome#index'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/signout' => 'sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
