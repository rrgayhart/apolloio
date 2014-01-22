class EveningReminderWorker 
  include Sidekiq::Worker

  def perform
    reminders = Reminder.where(time_deadline: "Evening At 19:00", active: true)
    reminders.each { |reminder| send_notification(reminder) }
  end

  def send_notification(reminder)
    user = reminder.user
    EmailNotifications.reminder_confirmation(user).deliver if reminder.email
    SmsNotifications.send_sms(user, reminder) if reminder.sms
  end
  
end
