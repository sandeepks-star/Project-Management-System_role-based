class SendEmailsJob < ApplicationJob
  queue_as :default

  def perform(developer, project)
    ProjectAssingmentMailer.project_assignment_email(developer, project).deliver_later
  end
end
