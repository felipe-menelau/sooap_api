Rails.application.routes.draw do
  post 'login', to: 'login#login'
  post 'sign_up', to: 'users#create'
  post 'appointment', to: 'appointments#create'
end
