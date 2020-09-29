class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :pokedex_number
      t.text :thumb

      t.timestamps
    end
  end
end
