puts "Cleaning database..."

Task.destroy_all
Project.destroy_all
User.destroy_all

puts "Creating Managers..."

manager_names = ["Sandeep Kumar", "Rahul Sharma", "Amit Verma"]

managers = manager_names.map do |name|
  User.create!(
    name: name,
    email: name.downcase.gsub(" ", "") + "@example.com",
    password: "Password@123",
    password_confirmation: "Password@123",
    role: :manager
  )
end

puts "Creating Developers..."

developer_names = [
  "Aman Gupta",
  "Priya Singh",
  "Rohit Mehta",
  "Neha Kapoor",
  "Vikas Yadav",
  "Anjali Rao",
  "Karan Malhotra",
  "Sneha Jain",
  "Arjun Patel",
  "Divya Nair"
]

developers = developer_names.map do |name|
  User.create!(
    name: name,
    email: name.downcase.gsub(" ", "") + "@example.com",
    password: "Password@123",
    password_confirmation: "Password@123",
    role: :developer
  )
end

puts "Creating Projects and Tasks..."

15.times do |project_index|

  manager = managers.sample

  project = Project.create!(
    name: "Project #{project_index + 1}",
    start_date: Date.today - rand(10),
    end_date: Date.today + rand(30..60),
    status: :pending,
    user_id: manager.id
  )

  # Assign random developers to project
  project.developers << developers.sample(rand(3..6))

  25.times do |task_index|

    task_status = Task.statuses.keys.sample

    task = Task.create!(
      name: "Task #{task_index + 1} for Project #{project_index + 1}",
      description: "This is task #{task_index + 1} description.",
      priority: Task.priorities.keys.sample,
      status: task_status,
      project: project
    )

    task.developers << developers.sample(rand(1..3))
  end

  # Update project status safely
  if project.tasks.where.not(status: :completed).count.zero?
    project.update!(status: :completed)
  else
    project.update!(status: [:pending, :in_progress].sample)
  end

end

puts "Seed completed successfully 🚀"