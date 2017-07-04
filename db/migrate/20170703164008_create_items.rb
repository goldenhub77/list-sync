class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.references :list, null: false
      t.string :title, null: false

      t.timestamps
    end
    add_index :items, :title, :unique => true
  end
end
