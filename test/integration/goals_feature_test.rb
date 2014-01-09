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
    assert_select('select#goal_target option[1]').first['value']
    # fill_in "Goal Target", :with => "Goal #1"
    assert_select('select#goal_target option[1]').first['value']
    fill_in "Goal Period", :with => "Goal #1"
    fill_in "Goal PeriodType", :with => "Goal #1"
    fill_in "Goal StartDate", :with => "Goal #1"
    fill_in "Goal StartDate", :with => "Goal #1"

    assert page.has_content?("")
    click_link "Add goal"

  end
end
