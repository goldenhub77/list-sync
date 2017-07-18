class AddColumnsForRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :lists_users, :role, :string, default: 'member', null: false
    add_index :users, :admin
    add_index :lists_users, :role
  end
end
