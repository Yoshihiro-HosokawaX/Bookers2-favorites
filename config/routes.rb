Rails.application.routes.draw do
  devise_for :users
  # devise_scope :user do
  #   authenticated :user do
  #     root :to => 'users#show', as: :root1
  #   end
  #   unauthenticated :user do
  #     root :to => 'books#home', as: :root2
  #   end
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # deviseではログイン認証が成功した時、rootパスにリダイレクトする
  root 'books#home'

  resources :users, only: [:show, :edit, :update, :index]

  resources :books do
    resource :favorites, only: [:create, :destroy]
  end

  get 'home/about' => 'books#about'


end
