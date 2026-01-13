class ChangeColumnPriorityInTask < ActiveRecord::Migration[8.1]
  def change
    change_column :tasks, :priority, :integer, default:0
  end
end
