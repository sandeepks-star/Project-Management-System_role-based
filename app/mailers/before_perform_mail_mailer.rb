class BeforePerformMailMailer < ApplicationMailer
  default from: "sandeepks@shriffle.com"

  def before_perform_mail_email(developer, project)
    mail(to: developer.email, subject: "You are going to be assigned in a project")
  end
end
