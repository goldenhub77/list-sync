Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :lists
  resources :lists do
    resources :items, except: [:index] do
      put 'complete'
    end
  end

  resources :users do
    get 'collaborations'
    get 'lists'
    resources :lists do
      post 'join'
      delete 'leave'
    end
  end

  get :autocomplete, controller: :main
  get :search, controller: :main

  root 'main#welcome'
end
