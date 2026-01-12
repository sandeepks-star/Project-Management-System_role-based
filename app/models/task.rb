class Task < ApplicationRecord
  belongs_to :project

  has_and_belongs_to_many :developers, class_name: "Developer", foreign_key: "task_id", join_table: "tasks_users", association_foreign_key: "user_id"

  validates :name, presence: true
  validates :description, presence: true
end
