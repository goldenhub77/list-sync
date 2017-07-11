class AddColumnItemsCompleted < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :completed, :boolean, null: false, default: false
    add_column :items, :date_completed, :timestamp
    add_index :items, [:date_completed, :completed]
  end
end
