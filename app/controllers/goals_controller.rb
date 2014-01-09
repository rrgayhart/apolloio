class GoalsController < ApplicationController
  def index
    @goals = Goal.where(user_id: current_user)
    @reminders = Reminder.where(user_id: current_user)
  end
end
