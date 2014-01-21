class ChangeDayDeadlineToStringOnRemindersTable < ActiveRecord::Migration
  def change
    change_column :reminders, :day_deadline, :string
  end
end
