class EndDateReminderMailJob < ApplicationJob
  queue_as :default

  def perform(developer, project)
    RemindEndDateMailer.end_date_reminder_email(developer_id, project).deliver_later
  end
end
