require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  before do
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)

    goal1 = Goal.create(user_id: @user.id, name:"Goal1")
    goal2 = Goal.create(user_id: @user.id, name:"Goal2")
    goal3 = Goal.create(user_id: @user.id, name:"Goal3")
    goal4 = Goal.create(user_id: @user.id+2, name:"Goal4")
    @goals = [goal1, goal2, goal3]

    visit root_path
    click_link "Log In"
  end

  test "logged in user navbar" do
    assert page.has_content?("Log Out")
    refute page.has_content?("Log In")
  end

  test "after user logs in they are redirected to dashboard" do
    assert_equal dashboard_path, current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Profile")
    assert page.has_content?("Goals")
    assert page.has_content?("Reminders")
  end

  test "logged in user sees only their goals" do
    @goals.each do |goal|
      assert page.has_content? goal.name
    end
    refute page.has_content? "Goal4"
  end
end
