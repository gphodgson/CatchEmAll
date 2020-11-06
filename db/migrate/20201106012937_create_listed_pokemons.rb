class CreateListedPokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :listed_pokemons do |t|
      t.boolean :caught
      t.references :checklist, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
