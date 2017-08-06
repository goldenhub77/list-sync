class AddColumnsNameAndProfilePictureToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :profile_picture, :string
  end
end
