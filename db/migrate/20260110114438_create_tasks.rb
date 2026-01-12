class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.string :priority
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
