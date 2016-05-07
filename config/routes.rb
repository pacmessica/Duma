Rails.application.routes.draw do
  root "articles#index"
  devise_for :users
  resources :words
  resources :articles do
    resources :tags
  end
end
