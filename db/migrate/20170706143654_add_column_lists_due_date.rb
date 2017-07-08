class AddColumnListsDueDate < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :due_date, :string
  end
end
