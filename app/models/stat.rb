class Stat < ApplicationRecord
  #======================
  # Pokemon
  #
  # Represents Pokemon table in database.
  #
  # Feilds
  # --------------------------
  # hp:               | Integer | Required, Numeric, Whole Number
  # attack            | Integer | Required, Numeric, Whole Number
  # defense           | Integer | Required, Numeric, Whole Number
  # special_attack    | Integer | Required, Numeric, Whole Number
  # special_defense   | Integer | Required, Numeric, Whole Number
  # speed             | Integer | Required, Numeric, Whole Number
  #
  # Assocations
  # --------------------
  # belongs to one `Pokemon`
  #
  #======================
  belongs_to :pokemon

  validates :hp, :attack, :defense, :special_attack, :special_defense, :speed, presence: true
  validates :hp, :attack, :defense, :special_attack, :special_defense, :speed, Numericality: { only_integer: true }
end
