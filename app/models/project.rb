class Project < ApplicationRecord
  enum :status, {
    pending: "0",
    in_progress: "1",
    completed: "2"
  }, default: :pending, validate: true

  belongs_to :manager,
             class_name: "User",
             foreign_key: "user_id",
             inverse_of: :managed_projects

  has_many :tasks, dependent: :destroy

  has_and_belongs_to_many :developers,
                          class_name: "User",
                          join_table: "projects_users",
                          foreign_key: "project_id",
                          association_foreign_key: "user_id"

  has_many_attached :avatars

  validates :name, :start_date, :end_date, presence: true
  validate :end_date_not_before_start_date

  scope :filter_by_status, ->(status) { statuses.key?(status) ? where(status: status) : all }

  private

  def end_date_not_before_start_date
    return if end_date.blank? || start_date.blank?
    return unless end_date < start_date

    errors.add(:end_date, "must be on or after start date")
  end
end
