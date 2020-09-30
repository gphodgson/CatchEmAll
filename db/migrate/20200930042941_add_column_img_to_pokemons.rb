class AddColumnImgToPokemons < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :img, :text
  end
end
