Rails.application.routes.draw do
  resources :stats, only: [:show]
  get "/pokemons/search/:search_term", to: "pokemons#search"
  resources :pokemons, only: %i[index show]
end
