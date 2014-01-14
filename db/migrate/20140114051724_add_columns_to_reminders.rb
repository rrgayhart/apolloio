class AddColumnsToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :day_deadline, :integer
    add_column :reminders, :time_deadline, :time
    add_column :reminders, :start_date, :date
  end
end
