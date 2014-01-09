require "./test/test_helper"

class NewUserSignupTest < Capybara::Rails::TestCase

  before do
    @auth = OmniAuth.config.mock_auth[:twitter]
  end

  test "user_signsup_for_app_and_is_redirected_to_twitter" do
    visit root_path
    assert_equal current_path, root_path
    click_link "Log In"

  end

end
