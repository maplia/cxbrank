Cxbrank::Application.routes.draw do
  get  'login',                to: 'login#index'
  post 'login/auth'

  resources :border, only: ['index']

  resources :musics, only: ['index']
  resources :skills, only: ['index', 'edit', 'update', 'destroy'] do
    member do
      post 'confirm'
      patch 'confirm'
    end
  end
  resources :view, only: ['show']
  resources :iglock, only: ['show']
  root to: 'top#index'
end
