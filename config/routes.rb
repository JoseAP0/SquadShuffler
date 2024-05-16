Rails.application.routes.draw do

  root 'players#index'

  get 'players/shuffle', to: 'players#shuffle'

  resources :players
end
