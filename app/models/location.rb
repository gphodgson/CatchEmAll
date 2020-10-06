#======================
# Location
#
# Represents Locations table in database.
#
# Feilds
# --------------------------
# Name:                 | String  | Required
# Img                   | Text    |
# Walk_Encounter_Rate   | Integer | Required, Numeric
# Surf_Encounter_Rate   | Text    | Required, Numeric
#
#======================

class Location < ApplicationRecord
  validates :name, :walk_encounter_rate, :surf_encounter_rate, presence: true
  validates :walk_encounter_rate, :surf_encounter_rate, numericality: true
end
