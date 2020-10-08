class CreateEncounters < ActiveRecord::Migration[6.0]
  def change
    create_table :encounters do |t|
      t.references :pokemons, null: false, foreign_key: true
      t.references :locations, null: false, foreign_key: true
      t.decimal :chance
      t.string :method

      t.timestamps
    end
  end
end
