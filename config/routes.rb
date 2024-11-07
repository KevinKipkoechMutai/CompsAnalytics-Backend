Rails.application.routes.draw do
  resources :notifications
  resources :comparable_properties
  resources :properties
  resources :accounts
  resources :transactions
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post "signup", to: "users#create"
  get "me", to: "users#show"
  get "users", to: "users#index"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  post "properties", to: "properties#create"
  get "properties", to: "properties#index"
  get "properties/id", to: "properties#show"
  delete "properties/id", to: "properties#destroy"
  get "accounts", to: "accounts#index"
  post "account/default", to: "accounts#default"
  
  #define path to valuation action

  post "value", to: "properties#valuation_create"
end
