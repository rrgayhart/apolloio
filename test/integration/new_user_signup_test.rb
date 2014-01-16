require "./test/test_helper"

class NewUserSignupTest < Capybara::Rails::TestCase

  before do
    @auth = OmniAuth.config.mock_auth[:twitter]
  end

  test "user_signs_up_for_app_and_is_redirected_to_connect_api_account" do
    visit root_path
    assert_equal current_path, root_path
    
    @auth = OmniAuth.config.mock_auth[:twitter]
    user = User.from_omniauth(@auth)
    api1  = FactoryGirl.create(:api, :github)
    api2  = FactoryGirl.create(:api, :fitbit)
    api3  = FactoryGirl.create(:api, :exercism)
    click_link "Log In"
    assert page.has_content?("Connect An API Account")
  end

end
