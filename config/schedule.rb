every :minute do
  runner "EndDateReminderMailWorker.perform_async", environment: :development
end