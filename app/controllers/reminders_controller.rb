class RemindersController < ApplicationController
  respond_to :html, :json

  def index
    @reminders = Reminder.where(user_id: current_user)
  end

  def create
    @add_email = params[:reminder][:add_email]
    if @add_email
      current_user.update(email: @add_email) 
    end
    @reminder = Reminder.new(reminder_params.except(:add_email))
    @reminder.user_id = current_user.id
    if @reminder.save
      redirect_to goal_path(@reminder.goal)
      flash[:success]="Reminder Successfully Saved"
    else
      redirect_to :back
      flash[:error]="Reminder Unsuccesful"
    end
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def edit
    @reminder = Reminder.find(params[:id])
  end

  def update
    @reminder = Reminder.find(params[:id])
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to @reminder, notice: 'Reminder successfully updated.' }
        format.json { respond_with_bip(@reminder) }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors }
      end
    end
  end

  private

  def reminder_params
    params.require(:reminder).permit(:goal_id, :start_date, :target, :time_deadline, :day_deadline, :twitter, :sms, :email, :add_email)
  end
end
