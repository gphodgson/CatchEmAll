class ChecklistController < ApplicationController
  def show
    @checklist = Checklist.find_by(unique_url_id: params[:id])
    @pokemons = @checklist.pokemons

    @not_caught_color = "#ff9e9e"
    @caught_color = "#75ff75"
  end

  def create
    list = Checklist.create(
      title:         "Untitled",
      unique_url_id: SecureRandom.uuid
    )

    Pokemon.all.each do |pokemon|
      list.listed_pokemons.create(
        caught:  false,
        pokemon: pokemon
      )
    end

    redirect_to("/checklist/?id=#{list.unique_url_id}")
  end
end
