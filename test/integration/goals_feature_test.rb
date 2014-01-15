require './test/test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    Capybara.current_driver = :selenium

    @auth  = OmniAuth.config.mock_auth[:twitter]
    @user  = User.from_omniauth(@auth)

    api1 = Api.create!(provider: 'Github')
    api2 = Api.create!(provider: 'Fitbit')
    api3 = Api.create!(provider: 'Exercism')
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
    reminder4 = Reminder.create(goal_id: goal1.id+1, user_id: @user.id+1, target: 55)
    @reminders = [reminder1, reminder2, reminder3]
    visit root_path
    click_link 'Log In'
  end

  test 'a goal and reminder can be added and viewed' do
    click_link 'Add Goal'
    assert page.has_css?('#create-goal-title')
    select('Github', :from => 'api_selection')
    select('1', :from => 'Target Goal')
    select('1', :from => 'Period')
    select('days', :from => 'Period Type')
    click_button "Submit Goal"
    assert page.has_css?('.goal-title')
    refute page.has_content?("Target")
    assert page.has_content?("Add Reminder")
    click_link "Add Reminder"
    assert page.has_css?(".reminder-submit-button")
    fill_in "Start date", :with => "01/09/2014"
    fill_in "Target", :with => "2"
    fill_in "Time deadline", :with => "4:00PM"
    fill_in "Day deadline", :with => "5"
    check "Twitter"
    check "Sms"
    check "Email"
    click_button "Create Reminder"
    assert page.has_content?('I am committing to reach 1 commit every 1 days')
    assert page.has_content?("View Reminder")
    assert page.has_content?("16:00:00")
    assert page.has_css?(".view-reminder-link")
    click_link "View Reminder"
    assert_equal goal_path(5), current_path
  end

end
