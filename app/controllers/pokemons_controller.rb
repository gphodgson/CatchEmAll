class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.all
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @prev_pokemon = Pokemon.find_by(id: @pokemon.id - 1)
    @next_pokemon = Pokemon.find_by(id: @pokemon.id + 1)
  end
end
