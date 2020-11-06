#======================
# Checklist
#
# Represents Checklist table in database.
#
# Feilds
# --------------------------
# Title           | String  | Not Required
# Unique Url Id   | String  | Required, Unique
#
# Associations
# --------------------
#
#======================

class Checklist < ApplicationRecord
  validates :unique_url_id, presence: true
  validates :unique_url_id, uniqueness: true

  has_many :listed_pokemons
  has_many :pokemons, through: :listed_pokemons
end
