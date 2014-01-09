require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  before do
    @auth = OmniAuth.config.mock_auth[:twitter]
    visit root_path
    click_link "Log In"
  end

  test "after_user_logs_in_they_are_redirected_to_dashboard" do
    assert_equal dashboard_path, current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Profile")
    assert page.has_content?("Goals")
    assert page.has_content?("Reminders")
  end

  test "logged in user navbar" do
    assert page.has_content?("Log Out")
    refute page.has_content?("Log In")
  end

end
