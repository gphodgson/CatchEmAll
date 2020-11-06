class ListedPokemon < ApplicationRecord
  belongs_to :pokemon
  belongs_to :checklist
end
