Rails.application.routes.draw do

  root 'products#index'

  resources :products

  resources :orders, only: %i[index show new create]

  resource :cart, only: %i[show destroy]
  patch 'carts/:id/update_discount' => 'carts#update_discount', as: 'update_discount'


  resources :line_items, only: %i[create update destroy]

end
