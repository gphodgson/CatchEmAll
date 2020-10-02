class AddWeightToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :weight, :integer
  end
end
