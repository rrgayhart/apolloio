require "test_helper"

class ReminderTest < ActiveSupport::TestCase

  def setup
    @user1 = FactoryGirl.create(:user)
    @api1 = FactoryGirl.create(:api, :github)
    @api_account1 = FactoryGirl.create(:api_account, api: @api1, user: @user1)
  end

  def teardown
    User.destroy_all
    Goal.destroy_all
    Reminder.destroy_all
    Api.destroy_all
    ApiAccount.destroy_all
  end

  def test_goal_render_renders_formatting_daily
    goal1 = FactoryGirl.create(:goal, period_type: "days", api_account: @api_account1)
    reminder = FactoryGirl.create(:reminder, user: @user1, goal: goal1)
    assert_equal "Daily", reminder.goal_render
  end

  def test_goal_render_renders_formatting_weekly
    goal1 = FactoryGirl.create(:goal, period_type: "weeks", api_account: @api_account1)
    reminder = FactoryGirl.create(:reminder, user: @user1, goal: goal1)
    assert_equal "Every Friday", reminder.goal_render
  end

  def test_goal_render_renders_formatting_monthly
    goal1 = FactoryGirl.create(:goal, period_type: "months", api_account: @api_account1)
    reminder = FactoryGirl.create(:reminder, user: @user1, goal: goal1)
    assert_equal "5th of the month", reminder.goal_render
  end
end
