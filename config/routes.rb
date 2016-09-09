Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
  resources :posts do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:show, :destroy. :edit, :update]

end
