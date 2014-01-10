require './test/test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    visit root_path
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    click_link "Log In"
  end

  test "typical_goal_thing" do
    click_link "Add Goal"
    assert page.has_content?("Create New Goal")
    fill_in "Name", :with => "Goal #1"
    fill_in "Goal Description", :with => "Goal #1"
    # Select API that goal is for
    select('Github', :from => 'Api Account')
    # Goal Target
    select('5', :from => 'Target')
    # Goal Period
    select('1', :from => 'Period')
    # Goal Period Type
    select('Day', :from => 'Period type')
    # Select Date from datepicker
    fill_in "Date", :with => "01/09/2014"
    click_link "Submit Goal"
  end

end
