require 'test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase
  setup do
    visit root_path

    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)

    click_link "Log In"
  end

  test "typical goal thing" do

    assert page.has_content?("")
    click_link "Add goal"

  end
end
