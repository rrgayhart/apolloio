require "test_helper"

class ProgressTest < ActiveSupport::TestCase

  def setup
    @user1 = FactoryGirl.create(:user)
    @github = FactoryGirl.create(:api, :github)
    @exercism = FactoryGirl.create(:api, :exercism)
    @api_account1 = FactoryGirl.create(:api_account, api: @github, user: @user1, api_username: "mhartl")
    @api_account2 = FactoryGirl.create(:api_account, api: @exercism, user: @user1, api_username: "rrgayhart")
  end

  def teardown
    User.destroy_all
    Goal.destroy_all
    Reminder.destroy_all
    Api.destroy_all
    ApiAccount.destroy_all
  end

  def test_progress_functions
    Timecop.freeze(Date.today) do
      VCR.use_cassette('rrgayhart1', :record => :new_episodes) do
        goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account2, target: 5, period: 4, period_type: "weeks", start_date: Date.today, commit_type: 'submission', language: 'ruby' )
        progress = Progress.new(goal)
        assert_equal '100', progress.result
      end
      end
    end

  def test_progress_prepares_the_progress_data_github
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
    Timecop.freeze(Date.today) do
      goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account1, target: 5, period: 1, period_type: "weeks", start_date: Date.today)
      progress = Progress.new(goal)
      assert_equal 1, progress.days_to_pull
      assert_equal 'Sun, 19 Jan 2014'.to_date, Date.today
    end
  end

  def test_days_to_pull_for_months
    Timecop.freeze(Date.today) do
      goal = FactoryGirl.create(:goal, user: @user1, api_account: @api_account1, target: 5, period: 1, period_type: "months", start_date: Date.today)
      progress = Progress.new(goal)
      assert_equal Date.today.mday, progress.days_to_pull
    end
  end
end
