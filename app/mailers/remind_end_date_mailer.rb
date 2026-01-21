class RemindEndDateMailer < ApplicationMailer
  default from: 'sandeepks@shriffle.com'

  def end_date_reminder_email(developer_id, project)
    @developer = developer_id
    @project = project

    mail(to: @developer.email, subject: "Project deadline date reminder. For project: #{@project}")
  end
end
