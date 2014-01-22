every 1.day, :at => '9am' do
  runner "MorningReminderWorker.perform_async"
end

every 1.day, :at => '2pm' do
  runner "AfternoonReminderWorker.perform_async"
end

every 1.day, :at => '7pm' do
  runner "EveningReminderWorker.perform_async"
end
