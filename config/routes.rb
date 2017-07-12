Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :lists
  resources :items, except: [:index]

  resources :lists do
    resources :items
  end

  root 'welcome#index'
end
