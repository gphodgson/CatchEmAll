class AddGameToEncounters < ActiveRecord::Migration[6.0]
  def change
    add_column :encounters, :game, :string
  end
end
