Rails.application.routes.draw do
  resources :pokemon, only: %i[index show]
end
