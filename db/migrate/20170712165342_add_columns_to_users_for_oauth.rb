class AddColumnsToUsersForOauth < ActiveRecord::Migration[5.1]
  def change
    #for omniauthable
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_index :users, :uid
  end
end
