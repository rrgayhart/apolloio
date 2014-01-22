class DashboardController < ApplicationController
  before_action :require_user
  before_action :require_api_account
  before_action :require_goal
  #before_action :public_shaming

  def index
    @goals        = current_user.goals
    @reminders    = current_user.reminders
    @api_accounts = current_user.api_accounts
  end

private

  def require_api_account
    unless current_user.has_api_account?
      redirect_to api_accounts_path
      flash[:no_apis] = "#{view_context.link_to('Add An API Account', 'api_accounts')}".html_safe
    end
  end

  def require_goal
    unless current_user.has_goal?
      flash[:no_goals] = "#{view_context.link_to('Add A Commitment', new_goal_path)}".html_safe
    end
  end

 # def public_shaming
 #   @goals = current_user.goals
 #   if current_user.has_goal? && current_user.email
 #     @goals.each do |goal|
 #       goal.reminders.each do |reminder|
 #         unless reminder.commitment_achieved?
 #           EmailNotifications.remind_user_of_commitment(current_user, reminder).deliver
 #         end
 #       end
 #     end
 #   end
 # end


end
