class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :project_name
      t.date :start_date
      t.date :end_date
      t.string :status

      t.timestamps
    end
  end
end
