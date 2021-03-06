Rails.application.routes.draw do

  get 'chats/show'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root to: 'homes#top'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  get '/home/about', to: 'homes#collection', as: 'about'
  delete '/books/:id', to: 'books#destroy', as: 'destroy_book'

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す

  get '/search', to: 'search#search'

  #'chat/:id'の:idは、ユーザid
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]

end

