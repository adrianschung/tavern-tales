Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :maps do
    resources :photos, only: [:create, :destroy]
  end
  resources :users, only: :show
end
