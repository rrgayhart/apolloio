require "test_helper"
require "mocha"

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

  def test_start_date_after_create
    current_date = DateTime.now.to_date
    reminder = FactoryGirl.create(:reminder, user: @user1)
    assert_equal current_date, reminder.start_date
  end

  def test_that_the_target_has_been_met_for_a_reminder
    Progress.any_instance.stubs(:result).returns("1")
    goal1= FactoryGirl.create(:goal, api_account: @api_account1)
    reminder = FactoryGirl.create(:reminder, goal: goal1)
    assert reminder.target_met?, "The reminders target has been met"
  end

  def test_that_the_target_has_not_been_met_for_a_reminder
    Progress.any_instance.stubs(:result).returns("20")
    goal1= FactoryGirl.create(:goal)
    reminder = FactoryGirl.create(:reminder, goal: goal1, target: 30)
    refute reminder.target_met?, "The reminders target has not been met"
  end

end
