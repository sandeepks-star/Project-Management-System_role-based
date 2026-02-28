class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { developer: 0, manager: 1 }

  # scope :first_user, -> {User.first}

  has_and_belongs_to_many :projects,
                          class_name: "Project",
                          join_table: "projects_users",
                          foreign_key: "user_id",
                          association_foreign_key: "project_id"

  has_many :managed_projects,
           class_name: "Project",
           foreign_key: "user_id",
           inverse_of: :manager,
           dependent: :destroy

  # has_and_belongs_to_many :projects_assigned,
  #                         class_name: "Project",
  #                         join_table: "projects_users",
  #                         foreign_key: "user_id",
  #                         association_foreign_key: "project_id"

  has_and_belongs_to_many :tasks,
                          class_name: "Task",
                          join_table: "tasks_users",
                          foreign_key: "user_id",
                          association_foreign_key: "task_id"

  validates :name, presence: true, format: { with: /\A[a-zA-Z\s]+\z/ }

end
