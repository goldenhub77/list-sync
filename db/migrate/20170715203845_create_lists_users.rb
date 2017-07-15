class CreateListsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :lists_users do |t|
      t.references :list, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
