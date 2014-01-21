every 1.day, :at => '9:00 am' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end

every 1.day, :at => '2:00 pm' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end

every 1.day, :at => '7:00 pm' do
  runner "MyModel.task_to_run_at_four_thirty_in_the_morning"
end
