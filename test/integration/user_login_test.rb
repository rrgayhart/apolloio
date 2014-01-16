require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase

  setup do
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)

    api1  = Api.create!(provider: 'Github')
    api2  = Api.create!(provider: 'Fitbit')
    api3  = Api.create!(provider: 'Exercism')
    @apis = [api1, api2, api3]

    @api_account1 = ApiAccount.create!(user_id: @user.id, api_id: api1.id, api_username: "john")
    @api_account2 = ApiAccount.create!(user_id: @user.id, api_id: api2.id, api_username: "steven")
    @api_account3 = ApiAccount.create!(user_id: @user.id, api_id: api3.id, api_username: "james")
    @api_account4 = ApiAccount.create(user_id: @user.id+1, api_id: api3.id+1, api_username: "beth")
    @api_accounts = [@api_account1, @api_account2, @api_account3] 
    
    goal1  = Goal.create!(user_id: @user.id, target:1, period:3, period_type:'months', start_date: Time.now, pledge:"Goal1", api_account_id: @api_account1.id )
    goal2  = Goal.create!(user_id: @user.id, target:1, period:3, period_type:'months', start_date: Time.now, pledge:"Goal2", api_account_id: @api_account2.id)
    goal3  = Goal.create!(user_id: @user.id, target:1, period:3, period_type:'months', start_date: Time.now, pledge:"Goal3", api_account_id: @api_account3.id)
    goal4  = Goal.create!(user_id: @user.id+1,target:1, period:3, period_type:'months', start_date: Time.now, pledge:"Goal4", api_account_id: @api_account4.id)
    @goals = [goal1, goal2, goal3]

    reminder1  = Reminder.create!(goal_id: goal1.id, user_id: @user.id, target: 403)
    reminder2  = Reminder.create!(goal_id: goal1.id, user_id: @user.id, target: 7852)
    reminder3  = Reminder.create!(goal_id: goal1.id, user_id: @user.id, target: 1986)
    @reminder4  = Reminder.create(goal_id: goal1.id+1, user_id: @user.id+1, target: 55)
    @reminders = [reminder1, reminder2, reminder3]

    visit root_path
    click_link "Log In"
  end

  test "user logs in and see's the expected items" do
    assert page.has_content?("Log Out"), "Page is missing 'Log Out' button"
    refute page.has_content?("Log In"), "Page is not supposed to have 'Log In' button"

    assert_equal dashboard_path, current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Profile"), "Page is missing content 'Profile'"
    assert page.has_content?("Goals"), "Page is missing content 'Goals'"
    assert page.has_content?("Reminders"), "Page is missing content 'Reminders'"
    refute page.has_content?("Add API Account"), "Page is missing 'Add API Account'"

    @goals.each do |goal|
      assert page.has_content?(goal.pledge), "Page is missing content #{goal.pledge}"
    end
    refute page.has_content?("Goal4"), "Page is not supposed to display 'Goal4'"

    @reminders.each do |reminder|
      assert page.has_content?(reminder.target), "Page is missing content #{reminder.target}"
    end
    refute page.has_content?(@reminder4.target), "Page is not suposed to display #{@reminder4.target}"

    @apis = [
       Api.find(@api_account1.api_id),
       Api.find(@api_account2.api_id),
       Api.find(@api_account3.api_id)
     ]
    @apis.each do |api|
      assert page.has_content?(api.provider), "Page is missing content #{api.provider}"
    end

    visit root_path
    click_link "Dashboard"
    assert_equal 200, page.status_code
    assert_equal dashboard_path, current_path
    click_link 'Log Out'
    assert page.has_content?("Log In"), "Page is missing 'Log In' button"
    refute page.has_content?("Log Out"), "Page is not supposed to have 'Log Out' button"
  end
end
