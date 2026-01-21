class Project < ApplicationRecord
  enum :status, { pending: 0, in_progress: 1, completed: 2 }

  belongs_to :manager, class_name: "User", foreign_key: "user_id"
  has_many :tasks, dependent: :destroy
  has_many_attached :avatars
  has_and_belongs_to_many :developers, class_name: "User", foreign_key: "project_id", join_table: "projects_users", association_foreign_key: "user_id"

  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  validate :all_tasks_status_completed, if: :status_changed?
  validate :end_date_must_be_after_start_date

  after_commit :send_email_to_developers

  default_scope -> {where(status: "pending")}
  scope :all_not_pending_projects, -> {where.not(status: 'pending')}
  scope :filter_by_status, -> (status) {where(status: status)}

  # def self.filter_by_status(status)
  #   where(status: status)
  # end

  # scope :all_in_progress_projects, -> {where(status: 'in_progress')}

  # scope :all_completed_projects, -> {where(status: 'completed')}

  private

  def end_date_must_be_after_start_date
    if end_date.present? || start_date.present?
      if end_date < start_date
        errors.add(:end_date, " must be after start date")
      end
    end
  end

  def send_email_to_developers
    developers.each do |developer|
      SendEmailsJob.perform_later(developer, self)
    end
  end

  def all_tasks_status_completed
    if tasks.exists? && completed? && tasks.not_completed.exists?
      errors.add(:status, " of tasks must be completed first")
    end
  end
end
