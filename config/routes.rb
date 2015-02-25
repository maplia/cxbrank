Cxbrank::Application.routes.draw do
  root :to => "top#index"
  get "login" => 'login#index'
  post "login/auth"
  get "skills" => 'skills#index'
end
