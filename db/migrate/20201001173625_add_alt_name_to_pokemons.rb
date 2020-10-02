class AddAltNameToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :alt_name, :text
  end
end
