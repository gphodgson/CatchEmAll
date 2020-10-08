class RemoveColumnWalkEncounterRateAndSurfEncounterRateFromLocation < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :walk_encounter_rate, :decimal
    remove_column :locations, :surf_encounter_rate, :decimal
  end
end
