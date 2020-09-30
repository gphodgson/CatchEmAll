class AddColumnColorToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :color, :string
  end
end
