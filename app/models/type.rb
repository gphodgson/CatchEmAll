#======================
# Type
#
# Represents Types table in database.
#
# Feilds
# --------------------------
# Name:           | String  | Required, Uniqueness
#
# Assocations
# --------------------
#
#======================
class Type < ApplicationRecord
  validates :names, presence: true
  validates :names, uniqueness: true
end
