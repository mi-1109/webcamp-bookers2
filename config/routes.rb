Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'

  resources :books, only: [:create, :index, :show, :edit, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  resources :user_images, only: [:create]
end
