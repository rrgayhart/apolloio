class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def reminder_confirmation(user)
    @user = user

    mail to: @user.email, subject:"New Reminder Confirmation"
  end
end
