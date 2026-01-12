class AddColumnStatusToTask < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :status, :string
    change_column_default :tasks, :status, "pending"
  end
end
