class CreateEncounters < ActiveRecord::Migration[6.0]
  def change
    create_table :encounters do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.decimal :chance
      t.string :method

      t.timestamps
    end
  end
end
