Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#index'
  resources :maps do
    resources :photos, only: [:create, :destroy]
  end
  get '/tagged', to: "maps#tagged", as: :tagged
  resources :users, only: :show
end
