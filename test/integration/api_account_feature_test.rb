require "test_helper"

class UserLoginTest < Capybara::Rails::TestCase
  setup do
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    goal = Goal.create(user_id: @user.id, pledge:"Goal")
    @api1 = Api.create(provider: 'Github', image_url: "githublogo.png")
    @api2 = Api.create(provider: 'Fitbit', image_url: "fitbitlogo.png")
    @api3 = Api.create(provider: 'Exercism', image_url: "exercismlogo.png")
    @api_account = FactoryGirl.create(:api_account, user: @user, api: @api1)

    visit root_path
    click_link 'Log In'
  end

  # As a user on the a github api account show page
  # I want to see my current streak

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
      fill_in("api_account_api_username", with: "jcasimir")
      click_button "Link My Account"
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("jcasimir")
    #Testing logo for api
    assert page.has_css?('#github-logo'), "Page is missing '#logo' element"
    #Testing the show page
    #click_link "jcasimir"
    #assert page.has_content?("Streak")
  end

  test "add a fitbit api account" do
    assert page.has_content?("Add An API Account")
    click_link "Add An API Account"
    assert page.has_content?("Connect An API Account")
    assert page.has_content?("Fitbit")
    assert page.has_css?("#fitbit_form")
    within("#fitbit_form") do
      fill_in("api_account_api_username", with: "jamesaccount")
      click_button "Link My Account"
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("jamesaccount")
    #Testing logo for api
    assert page.has_css?('#fitbit-logo'), "Page is missing '#logo' element"
    #Testing the show page
    #save_and_open_page
    #click_link "jamesaccount"
    #assert page.has_content?("Streak")
  end

  test "add an exercism api account" do
    assert page.has_content?("Add An API Account")
    click_link "Add An API Account"
    assert page.has_content?("Connect An API Account")
    assert page.has_content?("Exercism")
    assert page.has_css?("#exercism_form")
    within("#exercism_form") do
      fill_in("api_account_api_username", with: "markaccount")
      click_button "Link My Account"
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("markaccount")
        #Testing logo for api
    assert page.has_css?('#exercism-logo'), "Page is missing '#logo' element"
    #Testing the show page
    #click_link "markaccount"
    #assert page.has_content?("Streak")
  end

end
