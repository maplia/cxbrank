Cxbrank::Application.routes.draw do

  get  'login',                to: 'login#index'
  post 'login/auth'

  resources :users, only: ['index', 'new', 'create'] do
    collection do
      post 'confirm_new'
    end
  end
  resource :user, only: ['edit', 'update'] do
    member do
      patch 'confirm_edit'
    end
  end

  resources :musics, only: ['index']
  resources :border, only: ['index', 'show']

  resources :skills, only: ['index', 'edit', 'update', 'destroy'] do
    collection do
      get 'download'
    end
    member do
      post 'confirm'
      patch 'confirm'
    end
  end
  resources :view, only: ['show']
  resources :iglock, only: ['show']
  root to: 'top#index'
end
