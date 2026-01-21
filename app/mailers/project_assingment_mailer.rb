class ProjectAssingmentMailer < ApplicationMailer
  default from: 'sandeepsaket196@gmail.com'

  def project_assignment_email(developer_id, project)
    @dev_id = developer_id
    @project = project

    mail(to: @dev_id.email, subject: "You have been assigned in this #{@project.name}project ")
  end
end
