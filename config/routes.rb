Rails.application.routes.draw do
  get 'chats/show/:user_id', to:'chats#show', as:'chats'
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update] do
    member do
      get :following,:followers
    end
  end

  resources :books do
  	resource :book_comments, only: [:create, :destroy]
  	resources :favorites, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]

  root 'home#top'
  get 'home/about'

end
