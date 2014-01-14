class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    new_params = goal_params
    new_params[:user_id] = current_user.id
    @goal = Goal.create(new_params)
    if @goal.save
      redirect_to dashboard_path
    else
      render :new, notice: "Goal Unsuccessfully Created."
    end
  end

private

  def goal_params
    params.require(:goal).permit(:pledge, :api_account_id, :target, :period, :period_type, :start_date)
  end

end
