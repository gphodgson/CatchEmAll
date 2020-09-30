class Pokemon < ApplicationRecord
  #======================
  # Pokemon
  #
  # Represents Pokemon table in database.
  #
  # Feilds
  # --------------------------
  # Name:           | String  | Required
  # Pokedex_Number  | Integer | Required, Numeric, Whole Number
  # Thumb:          | Text    | Required
  #
  # Assocations
  # --------------------
  #
  #======================

  has_one :stat

  validates :name, :pokedex_number, :thumb, presence: true
  validates :pokedex_number, numericality: { only_integer: true }
end
