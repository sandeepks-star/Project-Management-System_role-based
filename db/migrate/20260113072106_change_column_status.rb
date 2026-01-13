class ChangeColumnStatus < ActiveRecord::Migration[8.1]
  def change
    change_column :projects, :status, :integer, default:0
  end
end
