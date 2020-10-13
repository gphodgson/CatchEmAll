#======================
# Type
#
# Represents Types table in database.
#
# Feilds
# --------------------------
# Name:   | String  | Required, Uniqueness
#
# Assocations
# --------------------
# Has many `Pokemon_Types`
# Connected to `Pokemon` via `Pokemon_Types`
#
#======================
class Type < ApplicationRecord
  has_many :pokemon_types
  has_many :pokemons, through: :pokemon_types
  validates :name, presence: true
  validates :name, uniqueness: true
end
