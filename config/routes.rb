Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :lists
  resources :lists do
    resources :items, except: [:index]
  end

  resources :users do
    resources :lists
  end


  root 'welcome#index'
end
