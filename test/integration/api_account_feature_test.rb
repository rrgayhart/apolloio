require "test_helper"

class ApiAccountFeatureTest < Capybara::Rails::TestCase

  setup do
    capybara_setup
    visit root_path
    click_link 'Log In'
  end

  # As a user on the a github api account show page
  # I want to see my current streak

  test "api account show page holds correct data for github accounts" do
    assert page.has_css?("#api_account_#{@api_account1.id}"), "Expecting link for api account"
    VCR.use_cassette('api_account_show_github_hartl', :record => :new_episodes) do
      within(".api-dashboard-div") do
        click_link @api_account1.api_username
      end
      assert page.has_content?("github"), "Page shoud have content GitHub"
      assert page.has_content?(@api_account1.api_username), "Page should have content #{@api_account1.api_username}"
      assert page.has_content?("Current Streak")
    end
  end

  test "add a github api account" do
    click_link "Add An API Account"
    assert page.has_content?("Connect An API Account")
    assert page.has_content?("Github")
    assert page.has_css?("#github_form")
    VCR.use_cassette('api_account_show_github') do
      within("#github_form") do
        fill_in("api_account_api_username", with: "jcasimir")
        click_button "Link My Account"
      end
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("jcasimir")
    assert page.has_css?('#github-logo'), "Page is missing '#logo' element"
  end

  test "add a duolingo api account" do
    skip
    assert page.has_content?("Add An API Account")
    click_link "Add An API Account"
    assert page.has_content?("Connect An API Account")
    assert page.has_content?("duolingo")
    assert page.has_css?("#duolingo_form")
    within("#duolingo_form") do
      fill_in("api_account_api_username", with: "novohispano")
      click_button "Link My Account"
    end
    assert page.has_content?("Added API Account")
    assert page.has_content?("novohispano")
    #Testing logo for api
    assert page.has_css?('#fitbit-logo'), "Page is missing '#logo' element"
    #Testing the show page
    #save_and_open_page
    #click_link "jamesaccount"
    #assert page.has_content?("Streak")
  end

  test "add an exercism api account" do
    skip
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
