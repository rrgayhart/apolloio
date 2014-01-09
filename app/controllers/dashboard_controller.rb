class DashboardController < ApplicationController
  before_action :require_api_account

  def index
    @goals = current_user.goals
    @reminders = current_user.reminders
    @api_accounts = current_user.api_accounts
  end

  private

  def require_api_account
    unless current_user.has_api_account?
      flash[:error]="Add API Account"
    end
  end
end
