#======================
# Location
#
# Represents Encounters table in database.
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
end
