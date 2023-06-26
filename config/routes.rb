Rails.application.routes.draw do
  get 'documents/show'
  namespace :admin do
    resources :projects
    resources :users
    resources :posts
    resources :comments

    root to: "projects#index"
  end

  root "home#index"

  devise_for :users

  resources :projects do
    resources :posts do
      resources :comments
    end
    resources :documents, only: [:create, :index, :show, :destroy]
  end

  devise_scope :user do
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end

  get "/error", to: "home#error"
end
