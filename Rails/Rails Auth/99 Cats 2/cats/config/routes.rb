Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new, :show] do
    member do
      post :approve
      post :deny
    end
  end

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
