Rails.application.routes.draw do

  devise_for :users
  resources :lists
  resources :items, except: [:index]

  resources :lists do
    resources :items
  end

  root 'welcome#index'
end
