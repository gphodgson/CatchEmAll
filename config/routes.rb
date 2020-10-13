Rails.application.routes.draw do
  resources :types, only: [:index, :show]
  resources :locations, only: [:index, :show]
  resources :stats, only: [:show]
  get "/pokemons/search", to: "pokemons#search"
  resources :pokemons, only: %i[index show]
end
