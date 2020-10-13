class Pokemon < ApplicationRecord
  #======================
  # Pokemon
  #
  # Represents Pokemon table in database.
  #
  # Feilds
  # --------------------------
  # Name:           | String  | Required
  # Alt_Name        | Text    | Required
  # Pokedex_Number  | Integer | Required, Numeric, Whole Number
  # Description     | Text    | Required
  # Img             | Text    | Required
  # Thumb:          | Text    | Required
  # Color           | String  |
  #
  # Assocations
  # --------------------
  # Has one `Stat`
  # Has many `Encounters`
  # Connected to `Locations` via `Encounters`
  # Has many `Pokemon_types`
  # Connected to `Types` via `Pokemon_Types`
  #
  #======================

  has_one :stat
  has_many :encounters
  has_many :locations, through: :encounters
  has_many :pokemon_types
  has_many :types, through: :pokemon_types

  validates :name, :alt_name, :pokedex_number, :description, :img, :thumb, presence: true
  validates :pokedex_number, numericality: { only_integer: true }

  def types_string
    str = types.first.name.capitalize
    str << " / #{types.last.name.capitalize}" if types.count > 1

    str
  end
end
