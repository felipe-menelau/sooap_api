Rails.application.routes.draw do
  post 'login', to: 'login#login'
  post 'sign_up', to: 'users#create'
end
