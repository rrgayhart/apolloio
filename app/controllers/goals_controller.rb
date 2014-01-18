class GoalsController < ApplicationController

  def new
    @goal             = Goal.new
    @api_accounts     = current_user.api_accounts
    @fitbit_account   = Api.find_by(provider: 'Fitbit')
    @exercism_account = Api.find_by(provider: 'Exercism')
  end

  def show
    @goal      = Goal.find(params['id'])
    @reminders = Reminder.new
  end

  def create
    new_params           = goal_params
    new_params[:user_id] = current_user.id
    @goal                = Goal.create(new_params)
    if @goal.save
      redirect_to goal_path(@goal)
    else
      flash[:error] = "Goal Unsuccessfully Created."
      redirect_to new_goal_path 
    end
  end

private

  def goal_params
    params.require(:goal).permit(:pledge, :api_account_id, :target, :period, :period_type, :start_date)
  end

end
