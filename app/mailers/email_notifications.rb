class EmailNotifications < ActionMailer::Base
  default from: "from@example.com"

  def reminder_confirmation(user)
    @user = user

    mail to: @user.email, subject:"New Reminder Confirmation"
  end

  def remind_user_of_commitment(user, reminder)
    @user = user
    @reminder = reminder
    mail to: user.email, subject: "Public Shaming Is A Great Motivator"
  end
end
