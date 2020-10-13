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
#
#======================
class Type < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
end
