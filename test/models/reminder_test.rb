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

  # def test_goal_render_renders_formatting_daily
  #   goal1    = FactoryGirl.create(:goal, period_type: "days", api_account: @api_account1)
  #   reminder = FactoryGirl.create(:reminder, user: @user1, goal: goal1)
  #   assert_equal "Daily", reminder.goal_render
  # end

  # def test_goal_render_renders_formatting_weekly
  #   goal1    = FactoryGirl.create(:goal, period_type: "weeks", api_account: @api_account1)
  #   reminder = FactoryGirl.create(:reminder, user: @user1, goal: goal1)
  #   assert_equal "Every Friday", reminder.goal_render
  # end

  # def test_goal_render_renders_formatting_monthly
  #   goal1    = FactoryGirl.create(:goal, period_type: "months", api_account: @api_account1)
  #   reminder = FactoryGirl.create(:reminder, user: @user1, goal: goal1)
  #   assert_equal "5th of the month", reminder.goal_render
  # end

  def test_start_date_after_create
    current_date = DateTime.now.to_date
    reminder     = FactoryGirl.create(:reminder, user: @user1)
    assert_equal current_date, reminder.start_date
  end

  def test_that_the_target_has_been_met_for_a_reminder
    Progress.any_instance.stubs(:result).returns("1")
    goal1    = FactoryGirl.create(:goal, api_account: @api_account1)
    reminder = FactoryGirl.create(:reminder, goal: goal1)
    assert reminder.target_met?, "The reminders target has been met"
  end

  def test_that_the_target_has_not_been_met_for_a_reminder
    Progress.any_instance.stubs(:result).returns("20")
    goal1    = FactoryGirl.create(:goal)
    reminder = FactoryGirl.create(:reminder, goal: goal1, target: 30)
    refute reminder.target_met?, "The reminders target has not been met"
  end

  def test_it_is_a_daily_reminder
    goal1 = FactoryGirl.create(:goal, period_type: "day")
    reminder = FactoryGirl.create(:reminder, goal: goal1)
    assert reminder.daily?, "It is a daily reminder"
  end

  def test_the_daily_target_has_been_met
    Progress.any_instance.stubs(:result).returns("1")
    goal1 = FactoryGirl.create(:goal, period_type: "day")
    reminder = FactoryGirl.create(:reminder, goal: goal1)
    assert reminder.daily_target_met?, "The daily target has been met"
  end

  def test_it_converts_period_of_day_to_hour
    reminder = FactoryGirl.create(:reminder, time_deadline: "Afternoon")
    assert_equal 14, reminder.change_to_hour
  end

  def test_it_compares_hour_correctly_to_current_hour
    Time.any_instance.stubs(:hour).returns(21)
    reminder = FactoryGirl.create(:reminder, time_deadline: "Evening")
    assert reminder.is_current_hour?, "Reminder Matches current hour"
  end

  def test_a_target_was_acheived
    Time.any_instance.stubs(:hour).returns(9)
    Progress.any_instance.stubs(:result).returns("1")
    goal1 = FactoryGirl.create(:goal, period_type: "day")
    reminder = FactoryGirl.create(:reminder,goal: goal1, time_deadline: "Morning")
    assert reminder.commitment_achieved?, "The target was achieved"
  end

  def test_target_was_not_achieved
    Time.any_instance.stubs(:hour).returns(9)
    Progress.any_instance.stubs(:result).returns("0")
    goal1 = FactoryGirl.create(:goal, period_type: "day")
    reminder = FactoryGirl.create(:reminder,goal: goal1, time_deadline: "Morning")
    refute reminder.commitment_achieved?, "The target was not achieved"
  end

  def test_it_is_a_weekly_reminder
    goal1 = FactoryGirl.create(:goal, period_type: "week")
    reminder = FactoryGirl.create(:reminder,goal: goal1, time_deadline: "Morning")
    assert reminder.weekly?, "Has a weekly target"
  end

  def test_it_has_met_its_weekly_target
    Progress.any_instance.stubs(:result).returns("1")
    goal1 = FactoryGirl.create(:goal, period_type: "week")
    reminder = FactoryGirl.create(:reminder,goal: goal1, time_deadline: "Morning")
    assert reminder.weekly_target_met?, "Has met  weekly target"
  end

  def test_it_has_a_monthly_reminder
    goal1 = FactoryGirl.create(:goal, period_type: "month")
    reminder = FactoryGirl.create(:reminder,goal: goal1, time_deadline: "Morning")
    assert reminder.monthly?, "Has a weekly target"
  end

  def test_it_has_met_its_monthly_target
    Progress.any_instance.stubs(:result).returns("1")
    goal1 = FactoryGirl.create(:goal, period_type: "month")
    reminder = FactoryGirl.create(:reminder,goal: goal1, time_deadline: "Morning")
    assert reminder.monthly_target_met?, "Has met monthly target"
  end

  def test_get_numerical_reprisentation_of_day
    reminder = FactoryGirl.create(:reminder, day_deadline: "Wednesday")
    assert_equal 3, reminder.numerical_day_of_week
  end

  def test_it_is_not_the_current_day
    Time.any_instance.stubs(:wday).returns(3)
    reminder = FactoryGirl.create(:reminder, day_deadline: "Wednesday")
    assert reminder.is_current_day?
  end
end
