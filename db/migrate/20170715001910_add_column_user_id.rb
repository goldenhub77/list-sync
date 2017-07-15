class AddColumnUserId < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :user_id, :bigint, null: false
    add_column :items, :user_id, :bigint, null: false
    add_index :lists, :user_id
    add_index :items, :user_id
  end
end
