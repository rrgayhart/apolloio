require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  before do
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)

    visit root_path
    click_link "Log In"
  end

  test "logged in user navbar" do
    assert page.has_content?("Log Out")
    refute page.has_content?("Log In")
  end

  test "after user logs in they are redirected to dashboard" do
    assert_equal dashboard_path, current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Profile")
    assert page.has_content?("Goals")
    assert page.has_content?("Reminders")
  end

  test "logged in user sees only their goals" do
    goal1 = Goal.create(user_id: @user.id, name:"Goal1")
    goal2 = Goal.create(user_id: @user.id, name:"Goal2")
    goal3 = Goal.create(user_id: @user.id, name:"Goal3")
    goal4 = Goal.create(user_id: @user.id+2, name:"Goal4")
    @goals = [goal1, goal2, goal3]

    visit dashboard_path

    @goals.each do |goal|
      assert page.has_content? goal.name
    end
    refute page.has_content? "Goal4"
  end

  test "logged in user sees only their reminders" do
    goal1 = Goal.create(user_id: @user.id, name:"Goal1")
    reminder1 = Reminder.create(goal_id: goal1.id, user_id: @user.id, target: 403)
    reminder2 = Reminder.create(goal_id: goal1.id, user_id: @user.id, target: 7852)
    reminder3 = Reminder.create(goal_id: goal1.id, user_id: @user.id, target: 1986)
    reminder4 = Reminder.create(goal_id: goal1.id + 1, user_id: @user.id + 1, target: 55)

    @reminders = [reminder1, reminder2, reminder3]

    visit dashboard_path

    @reminders.each do |reminder|
      assert page.has_content? reminder.target
    end
    refute page.has_content? reminder4.target
  end

  test "logged in user sees their api accounts" do
    #setup the the api accounts
    api1 = Api.create(provider: 'github')
    api2 = Api.create(provider: 'twitter')
    api3 = Api.create(provider: 'exercism')

    api_account1 = ApiAccount.create(user_id: @user.id, api_id: api1.id)
    api_account2 = ApiAccount.create(user_id: @user.id, api_id: api2.id)
    api_account3 = ApiAccount.create(user_id: @user.id, api_id: api3.id)
    api_account4 = ApiAccount.create(user_id: @user.id+1, api_id: api3.id+1)

    @apis = [
       Api.find(api_account1.api_id),
       Api.find(api_account2.api_id),
       Api.find(api_account3.api_id)
     ]

    visit dashboard_path

    @apis.each do |api|
      assert page.has_content? api.provider
    end
  end
end
