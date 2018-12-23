Rails.application.routes.draw do
  post 'login', to: 'login#login'
  post 'sign_up', to: 'users#create'
  resources :appointments, only: [:index, :create, :delete]
end
