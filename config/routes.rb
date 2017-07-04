Rails.application.routes.draw do

  resources :lists
  resources :items, except: [:index]

  resources :lists do
    resources :items
  end

  root 'welcome#index'
end
