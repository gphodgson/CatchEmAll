Rails.application.routes.draw do
  resources :about, only: [:index]
  resources :types, only: %i[index show]
  resources :locations, only: %i[index show]
  resources :stats, only: [:show]
  get "/pokemons/search", to: "pokemons#search"
  resources :pokemons, only: %i[index show]
end
