class ProjectAssingmentMailer < ApplicationMailer
  default from: 'sandeepks@shriffle.com'

  def project_assignment_email(developer, project)
    @project = project

    mail(to: developer.email, subject: "You have been assigned in this #{@project.name}project "
      )
  end
end
