#======================
# Location
#
# Represents Encounters table in database.
#
# Feilds
# --------------------------
# Chance  | String  | Required
# Method  | Text    | Required
#
# Associations
# --------------------
# Connects (Many to Many): `Pokemons` <--> `Locations`
# belongs to `Pokemons` & `Locations`
#
#======================

class Encounter < ApplicationRecord
  validates :chance, :method, presence: true
  validates :chance, numericality: true

  belongs_to :pokemons
  belongs_to :locations
end
