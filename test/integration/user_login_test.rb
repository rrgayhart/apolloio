require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  before do
    @auth = OmniAuth.config.mock_auth[:twitter]
  end

  test "after_user_logs_in_they_are_redirected_to_dashboard" do
    visit root_path

    click_link "Login"

    assert_equal dashboard_path, current_path

    assert_equal 200, page.status_code
    assert page.has_content?("Profile")
    assert page.has_content?("Goals")
    assert page.has_content?("Reminders")
  end
end
