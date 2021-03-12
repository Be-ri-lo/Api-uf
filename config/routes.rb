Rails.application.routes.draw do
  resources :user_requests
  resources :clients
  resources :ufs, param: :date  #se cambia :id por :date, para no generar confusio
  
  root "ufs#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
