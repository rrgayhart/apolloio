require "test_helper"

class ProgressTest < ActiveSupport::TestCase

  def setup
    @user1 = FactoryGirl.create(:user)
    @github = FactoryGirl.create(:api, :github)
    @api_account1 = FactoryGirl.create(:api_account, api: @github, user: @user1, api_username: "mhartl")
  end

  def teardown
    User.destroy_all
    Goal.destroy_all
    Reminder.destroy_all
    Api.destroy_all
    ApiAccount.destroy_all
  end

  def test_progress_prepares_the_progress_data
    VCR.use_cassette('hartl_history') do
      goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account1, target: 5, period: 1, period_type: "days", start_date: Date.today)
      progress = Progress.new(goal)
      assert_equal "80", progress.result
    end
  end

  def test_days_to_pull_for_days
    goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account1, target: 5, period: 1, period_type: "days", start_date: Date.today)
    progress = Progress.new(goal)
    assert_equal 1, progress.days_to_pull
  end

  def test_days_to_pull_for_weeks
    goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account1, target: 5, period: 1, period_type: "weeks", start_date: Date.today)
    progress = Progress.new(goal)
    assert_equal Date.today.wday, progress.days_to_pull
  end

  def test_days_to_pull_for_months
    goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account1, target: 5, period: 1, period_type: "months", start_date: Date.today)
    progress = Progress.new(goal)
    assert_equal Date.today.mday, progress.days_to_pull
  end
end
