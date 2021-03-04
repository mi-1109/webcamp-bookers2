Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]

  get '/about', to: 'homes#collection', as: 'about'
  delete '/books/:id', to: 'books#destroy', as: 'destroy_book'


end

