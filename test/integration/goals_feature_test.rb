require 'test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    visit root_path
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    click_link "Log In"
  end

  test "typical goal thing" do
    assert page.has_content?("Add Goal")
    click_link "Add Goal"
    assert page.has_content?("Create New Goal")
    fill_in "Goal Name", :with => "Goal #1"
    fill_in "Goal Description", :with => "Goal #1"
    # Select API that goal is for
    select('GitHub', :from => 'Select Box')
    # Goal Target
    select('5', :from => 'Select Box')
    # Goal Period
    select('1', :from => 'Select Box')
    # Goal Period Type
    select('Day', :from => 'Select Box')
    # Select Date from datepicker
    page.execute_script("$('#goal_start_date').val('1/09/2014')")
    click_link "Submit Goal"
  end
  
end
