require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase

  setup do
    capybara_setup
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
    refute page.has_content?(@goal4.pledge), "Page is not supposed to display 'Goal4'"

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
