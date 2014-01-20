class DashboardController < ApplicationController
  before_action :require_user
  before_action :require_api_account
  before_action :require_goal

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
      flash[:no_goals] = "#{view_context.link_to('Add A Goal', new_goal_path)}".html_safe
    end
  end

end
