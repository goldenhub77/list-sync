class AddColumnItemsCompleted < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :completed, :timestamp
    add_index :items, :completed
  end
end
