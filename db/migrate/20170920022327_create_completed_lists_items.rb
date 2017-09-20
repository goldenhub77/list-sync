class CreateCompletedListsItems < ActiveRecord::Migration[5.1]
  def change
    create_table :completed_lists_items do |t|
      t.references :item, null: false
      t.references :user, null: false

      t.timestamps
    end
  end
end
