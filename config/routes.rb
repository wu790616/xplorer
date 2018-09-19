Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update] do
    resources :notifications, only: [:index]
  end

  resources :topics, only: [:index, :show]

  resources :issues, except: [:index] do
    resources :comments, only: [:create, :destroy] do
      resources :replies, only: [:create, :destroy]
    end
  end

  resources :user_followships, only: [:create, :destroy]
  resources :topic_followships, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  resources :search, only: [:index]

  root "topics#index"
end
