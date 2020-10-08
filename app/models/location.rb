#======================
# Location
#
# Represents Locations table in database.
#
# Feilds
# --------------------------
# Name:                 | String  | Required
# Img                   | Text    |
#
# Associations
# --------------------
# Has many `Encounters`
# Connected to `Pokemons` via `Encounters`
#
#======================

class Location < ApplicationRecord
  validates :name, presence: true

  has_many :encounters
  has_many :pokemons, through: :encounters
end
