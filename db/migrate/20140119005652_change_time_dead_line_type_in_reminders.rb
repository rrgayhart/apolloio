class ChangeTimeDeadLineTypeInReminders < ActiveRecord::Migration
  def change
    change_column :reminders, :time_deadline, :string
  end
end
