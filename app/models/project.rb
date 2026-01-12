class Project < ApplicationRecord

  has_many_attached :avatars
  belongs_to :manager, class_name: 'User', foreign_key: "user_id"

  has_and_belongs_to_many :developers, class_name: "User", foreign_key: "project_id", join_table: "projects_users", association_foreign_key: "user_id"

  has_many :tasks, dependent: :destroy

  validates :project_name, presence: true, uniqueness: true
  validate :end_date_must_be_after_start_date

  private

  def end_date_must_be_after_start_date
    if end_date < start_date
      errors.add(:end_date, " must be after start date")
    end
  end
end
