class AddDefaultValuesToReminders < ActiveRecord::Migration
  def change
    change_column :reminders, :twitter, :boolean, :default => false
    change_column :reminders, :email, :boolean, :default => false
    change_column :reminders, :sms, :boolean, :default => false
  end
end
