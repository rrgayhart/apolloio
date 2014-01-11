require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  setup do
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    goal = Goal.create(user_id: @user.id, name:"Goal")
    @api1 = Api.create(provider: 'Github')
    @api2 = Api.create(provider: 'Fitbit')
    @api_account = FactoryGirl.create(:api_account, user: @user, api: @api1)

    visit root_path
    click_link 'Log In'
  end

  test "api account show page holds correct data for github accounts" do
    assert page.has_css?("#api_account_#{@api_account.id}"), "Expecting link for api account"
    click_link @api_account.api_username
    assert page.has_content?("Github"), "Page shoud have content GitHub"
    assert page.has_content?("mhartl"), "Page should have content #{@api_account.api_username}"
    assert page.has_content?("Languages")
    assert page.has_content?("Current Streak")
    assert page.has_content?("Commits This Year")
    assert page.has_content?("Number of Repos")
    assert page.has_content?("Goals List")
  end

  test "add a github api account" do
    assert page.has_content?("Add An API Account")
    click_link "Add An API Account"
    assert page.has_content?("Connect An API Account")
    assert page.has_content?("Github")
    assert page.has_css?("#github_form")
    within("#github_form") do
      fill_in("api_account_api_username", with: "Bobs API")
      click_button "Create Api account"
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("Bobs API")
  end

  test "add a fitbit api account" do
    assert page.has_content?("Add An API Account")
    click_link "Add An API Account"
    assert page.has_content?("Connect An API Account")
    assert page.has_content?("Fitbit")
    assert page.has_css?("#fitbit_form")
    within("#fitbit_form") do
      fill_in("api_account_api_username", with: "James API")
      click_button "Create Api account"
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("James API")
  end

end
