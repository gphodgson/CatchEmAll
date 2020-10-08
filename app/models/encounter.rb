#======================
# Location
#
# Represents Encounters table in database.
#
# Feilds
# --------------------------
# Chance  | String  | Required
# Method  | Text    | Required
# Game    | String  | Required, Within (`red`, `blue`, `yellow`)
#
# Associations
# --------------------
# Connects (Many to Many): `Pokemons` <--> `Locations`
# belongs to `Pokemons` & `Locations`
#
#======================

class Encounter < ApplicationRecord
  validates :chance, :method, :game, presence: true
  validates :chance, numericality: true

  belongs_to :pokemon
  belongs_to :location
end
