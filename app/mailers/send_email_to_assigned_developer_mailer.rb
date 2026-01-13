class SendEmailToAssignedDeveloperMailer < ApplicationMailer
  default from: 'alt.d4-doyrhqxu@yopmail.com'

  def project_or_task_assignment_confirmation(project)
    @project = project
    byebug
    developer_emails = @project.developers.pluck(:email)
    byebug
    mail(to: developer_emails, subject: "Project assignment update")
  end
end
