require './test/test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    visit root_path
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    click_link "Log In"
  end

  test "typical_goal_thing" do
    skip
    # Not sure exactly how to test this section unless we setup selenium or something
    click_link "Add Goal"
    assert page.has_content?("Create New Goal")

    # fill_in "Goal Name", :with => "Goal #1"
    # fill_in "Goal Description", :with => "Goal #1"
    # # Select API that goal is for
    # select('Github', :from => 'Api Account')
    # # Goal Target
    # select('5', :from => 'Target')
    # # Goal Period
    # select('1', :from => 'Period')
    # # Goal Period Type
    # select('Day', :from => 'Period Type')
    # # Select Date from datepicker
    # fill_in "Start Date", :with => "01/09/2014"
    # click_button "Submit Goal"

  end

end
