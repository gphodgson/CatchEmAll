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
#======================

class Location < ApplicationRecord
  validates :name, presence: true
end
