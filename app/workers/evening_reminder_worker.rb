# class EveningReminderWorker 
#   include Sidekiq::Worker

#   def perform
#     # find all reminders that are at morning
#     reminders = Reminder.where(time_deadline: "Evening", active: true)
#     reminders.each { |reminder| send_notification(reminder) }
#   end

#   def send_notification(reminder)
#     user = reminder.user
#     # send email if notification.email?
#     EmailNotifications.reminder_confirmation(user).deliver if reminder.email
#     # send sms if notification.sms?
#     SmsNotifications.send_sms(user, reminder) if reminder.sms
#   end
  
end
