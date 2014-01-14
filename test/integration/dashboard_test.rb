require "test_helper"

class DashboardTest < Capybara::Rails::TestCase
  setup do
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    @goal1 = Goal.create(user_id: @user.id, pledge:"Goal1")
    @goal2 = Goal.create(user_id: @user.id, pledge:"Goal2")
    @goal3 = Goal.create(user_id: @user.id, pledge:"Goal3")
    @goal4 = Goal.create(user_id: @user.id+2, pledge:"Goal4")
    @goals = [@goal1, @goal2, @goal3]

    @reminder1 = Reminder.create(goal_id: @goal1.id, user_id: @user.id, target: 403)
    @reminder2 = Reminder.create(goal_id: @goal1.id, user_id: @user.id, target: 7852)
    @reminder3 = Reminder.create(goal_id: @goal1.id, user_id: @user.id, target: 1986)
    @reminder4 = Reminder.create(goal_id: @goal1.id + 1, user_id: @user.id + 1, target: 55)
    @reminders = [@reminder1, @reminder2, @reminder3]

    @api1 = Api.create(provider: 'github')
    @api2 = Api.create(provider: 'twitter')
    @api3 = Api.create(provider: 'exercism')

    @api_account1 = ApiAccount.create(user_id: @user.id, api_id: @api1.id, api_username: "john")
    @api_account2 = ApiAccount.create(user_id: @user.id, api_id: @api2.id, api_username: "steven")
    @api_account3 = ApiAccount.create(user_id: @user.id, api_id: @api3.id, api_username: "james")
    @api_account4 = ApiAccount.create(user_id: @user.id+1, api_id: @api3.id+1, api_username: "beth")
    visit root_path
  end

  test "user clicks on a goal and goes to the goal show page" do
    click_on 'Log In'
    assert page.has_content? @goal1.pledge
    click_link @goal1.pledge
  end

end
