class ChecklistController < ApplicationController
  def show
    @checklist = Checklist.find_by(unique_url_id: params[:id])
    @pokemons = Pokemon.all
  end

  def create
    list = Checklist.create(
      title:         "Untitled",
      unique_url_id: SecureRandom.uuid
    )

    redirect_to("/checklist/?id=#{list.unique_url_id}")
  end
end
