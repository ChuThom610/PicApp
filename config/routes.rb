Rails.application.routes.draw do
  resources :hashtags
  resources :albums
  
  devise_for :users 
  resources :comments
  get 'pages/info'

  root to: redirect('/pics')
  resources :pics
  resource :user
  get 'tags/:tag', to: 'pics#hashtag', as: :tag

  namespace :admin do
    resources :users do
      get 'delete'
      put "lock"
      put "unlock"
    end
  end 
  
end
