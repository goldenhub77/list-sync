class CreateFriendsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :friends_users do |t|
      t.bigint :user_id, null: false
      t.bigint :friend_id, null: false

      t.timestamps
    end
    add_index(:friends_users, [:user_id, :friend_id], :unique => true)
    add_index(:friends_users, [:friend_id, :user_id], :unique => true)
  end
end
