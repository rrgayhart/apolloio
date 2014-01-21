class RemindersController < ApplicationController
  respond_to :html, :json

  def index
    @reminders = Reminder.where(user_id: current_user)
  end

  def create
    @add_email        = params[:reminder][:add_email]
    @add_phone_number = params[:reminder][:add_phone_number]
    if @add_email
      current_user.update(email: @add_email) 
    end
    if @add_phone_number
      current_user.update(phone_number: @add_phone_number) 
    end
    @reminder = Reminder.new(reminder_params.except(:add_email))
    @reminder.user_id = current_user.id
    if @reminder.save
      redirect_to goal_path(@reminder.goal)
      flash[:success]="Reminder Successfully Saved"
      UserMailer.reminder_confirmation(current_user).deliver
      send_sms
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
    params.require(:reminder).permit(:goal_id, :start_date, :target, :time_deadline, :day_deadline, :twitter, :sms, :email, :add_email, :add_phone_number)
  end

  def send_sms
    # Instantiate a Twilio client
    client = Twilio::REST::Client.new(TWILIO_CONFIG['sid'], TWILIO_CONFIG['token'])
      
    # Create and send an SMS message
    client.account.sms.messages.create(
      from: TWILIO_CONFIG['from'],
      to: current_user.phone_number,
      body: "A reminder was created. It will notify you via SMS the #{@reminder.time_deadline} of every #{@reminder.day_deadline} day if you haven't hit your #{@reminder.target} commit."
    )
  end
end
