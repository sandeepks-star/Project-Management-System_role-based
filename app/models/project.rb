class Project < ApplicationRecord
	belongs_to :manager, class_name: 'User', foreign_key: "user_id"

  has_and_belongs_to_many :developers, class_name: "User", foreign_key: "project_id", join_table: "projects_users", association_foreign_key: "user_id" 

  has_many :tasks

  validates :project_name, presence: true, uniqueness: true
  validate :end_date_must_be_after_start_date

  private

  def end_date_must_be_after_start_date
    return puts "End date must be after start date" if end_date < start_date
  end
end
