Rails.application.routes.draw do
  resources :cats
  resources :cat_rental_requests, only: [:create, :new, :show] do
    member do
      get :approve
      post :deny
    end
  end
end
