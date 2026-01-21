class Task < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2 }
  enum :priority, { low: 0, medium: 1, high: 2 }

  belongs_to :project
  has_and_belongs_to_many :developers, class_name: "Developer", foreign_key: "task_id", join_table: "tasks_users", association_foreign_key: "user_id"

  validates :name, presence: true
  validates :description, presence: true
end
