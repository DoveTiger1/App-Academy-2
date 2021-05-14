Rails.application.routes.draw do
  resources :users, only: [:create, :index, :show, :update, :destroy] do
    resources :artworks, only: [:index]
    resources :collections, only: [:index]
  end

  resources :artworks, only: [:create, :show, :update, :destroy] do
    member do
      post :like, to: 'artworks#like', as: 'like'
      post :unlike, to: 'artworks#unlike', as: 'unlike'
      post :favorite, to: 'artworks#favorite', as: 'favorite'
      post :unfavorite, to: 'artworks#unfavorite', as: 'unfavorite'
    end
  end
  
  resources :artworkshares, only: [:create, :destroy] do
    member do
      post :favorite, to: 'artworkshares#favorite', as: 'favorite'
      post :unfavorite, to: 'artworkshares#unfavorite', as: 'unfavorite'
    end
  end

  resources :comments, only: [:create, :destroy, :index] do
    member do
      post :like, to: 'comments#like', as: 'like'
      post :unlike, to: 'comments#unlike', as: 'unlike'
    end
  end

  resources :collections, only: [:show, :create, :destroy] do
    resources :artworks, only: [:index] do
      post :add, to: 'collections#add_artwork', as: 'add'
      delete :remove, to: 'collections#remove_artwork', as: 'remove'
    end
  end
end
