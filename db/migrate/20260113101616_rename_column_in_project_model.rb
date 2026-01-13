class RenameColumnInProjectModel < ActiveRecord::Migration[8.1]
  def change
    rename_column :projects, :project_name, :name
  end
end
