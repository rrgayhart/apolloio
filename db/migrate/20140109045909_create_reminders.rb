class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.references :user, index: true
      t.references :goal, index: true
      t.integer :target
      t.time :deadline
      t.boolean :twitter
      t.boolean :email
      t.boolean :sms

      t.timestamps
    end
  end
end
