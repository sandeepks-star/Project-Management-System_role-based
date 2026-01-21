class RemindEndDateMailer < ApplicationMailer
  default from: "sandeepks@shriffle.com"

  def remind_end_date_email(developer, project)
    @project = project
    mail(to: developer.email,
      subject: "Project deadline date reminder. For project: #{@project.name}"
      )
  end
end
