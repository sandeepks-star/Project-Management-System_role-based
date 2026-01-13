class ChangeColumnStatusInTask < ActiveRecord::Migration[8.1]
  def change
    change_column :tasks, :status, :integer, default:0
  end
end
