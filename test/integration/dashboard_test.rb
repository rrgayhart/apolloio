require "test_helper"

class DashboardTest < Capybara::Rails::TestCase
  setup do
    capybara_setup
    visit root_path
  end

  test "user clicks on a goal and goes to the goal show page" do
    click_on 'Log In'
    assert page.has_content? @goal1.pledge
    VCR.use_cassette('dashboard_to_goal_show2') do
      click_link @goal1.pledge
      assert page.has_content? @goal1.api_account.api_username
      click_link @goal1.api_account.api_username
      assert_equal api_account_path(@goal1.api_account), current_path
    end
  end

end
