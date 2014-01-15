require './test/test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    Capybara.current_driver = :selenium
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)    

    api1 = FactoryGirl.create(:api, :github)
    api2 = FactoryGirl.create(:api, :fitbit)
    api3 = FactoryGirl.create(:api, :exercism)

    FactoryGirl.create(:goal, user: @user)
    FactoryGirl.create(:api_account, api: api1)
    # FactoryGirl.create(:goal, user: @user)

    visit root_path
    click_link 'Log In'
  end

  test 'a goal and reminder can be added' do
    click_link 'Add Goal'
    assert page.has_content?('Create A New Goal')
    select('Github', :from => 'api_selection')
    select('1', :from => 'Target Goal')
    select('1', :from => 'Period')
    select('days', :from => 'Period Type')
    fill_in "Start Date", :with => "01/09/2014"
    click_button "Submit Goal"
    assert page.has_content?('Pledge: My goal is to reach 1 commit every 1 days')
    click_link 'My goal is to reach 1 commit every 1 days'
    refute page.has_content?("Target")
    assert page.has_content?("Add Reminder")
    click_link "Add Reminder"
    assert page.has_content?("Target")
    fill_in "Start date", :with => "01/09/2014"
    fill_in "Target", :with => "2"
    fill_in "Time deadline", :with => "4:00PM"
    fill_in "Day deadline", :with => "5"
    check "Twitter"
    check "Sms"
    check "Email"
    click_button "Create Reminder"
    assert page.has_content?('My goal is to reach 1 commit every 1 days')
    # verify new reminder is on page
    


  end

end
