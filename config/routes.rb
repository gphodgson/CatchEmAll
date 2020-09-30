Rails.application.routes.draw do
  resources :stats, only: [:show]
  resources :pokemons, only: %i[index show]
end
