Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit] do
    resources :notifications, only: [:index]
  end

  resources :topics, only: [:index, :show]

  resources :issues, only: [:show, :create, :edit, :update, :destroy] do
    resources :comments, only: [:create] do
      resources :replies, only: [:create]
    end
  end

  resources :userfollowships, only: [:create, :destroy]
  resources :topicfollowships, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  resources :search, only: [:index]

  root "topics#index"
end
