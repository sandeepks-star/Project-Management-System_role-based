class EndDateReminderMailWorker
  include Sidekiq::Worker

  def perform(*args)
    projects = Project.where(end_date: Date.tomorrow).includes(:developers)
    if projects.present?
      projects.each do |project|
        if project.developers.present?
          project.developers.each do |developer|
            RemindEndDateMailer.remind_end_date_email(developer, project).deliver_now
          end
        end
      end
    end
  end
end
