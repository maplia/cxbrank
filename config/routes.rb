Cxbrank::Application.routes.draw do
  root                         to: 'top#index'
  get  'login',                to: 'login#index'
  post 'login/auth'
  get  'musics',               to: 'musics#index'
  get  'skills',               to: 'skills#index'
  get  'skills/edit/:text_id', to: 'skills#edit'
end
