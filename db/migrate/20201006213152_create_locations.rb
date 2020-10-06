class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.text :img
      t.decimal :walk_encounter_rate
      t.decimal :surf_encounter_rate

      t.timestamps
    end
  end
end
