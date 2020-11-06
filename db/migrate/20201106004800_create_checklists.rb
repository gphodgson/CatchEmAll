class CreateChecklists < ActiveRecord::Migration[6.0]
  def change
    create_table :checklists do |t|
      t.string :title
      t.string :unique_url_id

      t.timestamps
    end
  end
end
