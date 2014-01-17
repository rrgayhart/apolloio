class AddColumnToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :active, :boolean, default: true
  end
end
