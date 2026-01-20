class SendEmailsJob < ApplicationJob
  queue_as :default

  before_perform do |job|
    byebug
    arguments = job.arguments
    BeforePerformMailMailer.before_perform_mail_email(arguments.first, arguments.second ).deliver_now
  end

  def perform(developer, project)
    ProjectAssingmentMailer.project_assignment_email(developer, project).deliver_later
  end
end
