Rails.application.routes.draw do
  get "/checklist", to: "checklist#show"
  get "/checklist/create"
  resources :about, only: [:index]
  resources :types, only: %i[index show]
  resources :locations, only: %i[index show]
  resources :stats, only: [:show]
  get "/pokemons/search", to: "pokemons#search"
  resources :pokemons, only: %i[index show]
  get "/", to: "pokemons#index"
end
