class GoalsController < ApplicationController
  def index
    @goals = current_user.goals
    @reminders = current_user.reminders
    @api_accounts = current_user.api_accounts
  end
end
