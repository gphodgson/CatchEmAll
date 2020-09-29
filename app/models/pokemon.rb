class Pokemon < ApplicationRecord
  #======================
  # Pokemon
  #
  # Represents Pokemon table in database.

  validates :name, :pokedex_number, :thumb, presence: true
  validates :pokedex_number, numericality: { only_integer: true }
end
