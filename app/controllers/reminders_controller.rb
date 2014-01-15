class RemindersController < ApplicationController
  def index
    @reminders = Reminder.where(user_id: current_user)
  end

  def create
    reminder = Reminder.new(reminder_params)
    reminder.user_id = current_user.id
    if reminder.save
      redirect_to :back
      flash[:success]="Reminder Successfully Saved"
    else
      redirect_to :back
      flash[:success]="oh shit"
    end
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

private

  def reminder_params
    params.require(:reminder).permit(:goal_id,:start_date, :target, :time_deadline, :day_deadline, :twitter, :sms, :email)
  end
end
