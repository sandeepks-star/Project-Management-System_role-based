class Developer < User
	has_and_belongs_to_many :assigned_projects, class_name: "Project", join_table: 'projects_users', foreign_key: "user_id", association_foreign_key: "project_id"
  has_and_belongs_to_many :tasks, foreign_key: "user_id", join_table: 'tasks_users', association_foreign_key: "task_id"
end
