class RemindersController < ApplicationController
  def index
    @reminders = Reminder.where(user_id: current_user)
  end
end
