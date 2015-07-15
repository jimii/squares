Rails.application.routes.draw do

  root 'start#index'

  resources :spots

end
