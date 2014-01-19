require "test_helper"

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    Capybara.current_driver = :webkit
    capybara_setup
    visit root_path
    click_link 'Log In'
  end

  test 'a goal and reminder can be added and viewed' do
    VCR.use_cassette('goal_progress2') do
      click_link 'Add Goal'
      assert page.has_css?('#create-goal-title')
      select('Github', :from => 'api_selection')
      select('1', :from => 'Target Goal')
      select('1', :from => 'Period')
      select('day', :from => 'Period Type')
      click_button "Submit Goal"
      refute page.has_content?("Target")
      assert page.has_content?("Add Reminder")
      click_link "Add Reminder"
      assert page.has_css?(".reminder-submit-button")
      fill_in "Target", :with => "2"
      #fill_in "Time deadline", :with => "morning"
      select("afternoon", :from => "Time Deadline")
      fill_in "Day deadline", :with => "5"
      check "Twitter"
      check "Sms"
      check "Email"
      assert page.has_content?("Enter email address:")
      fill_in "reminder[add_email]", :with => "example@example.org"
      click_button "Create Reminder"
      click_link "Add Reminder"
      check "Email"
      refute page.has_content?("Enter email address:")
      assert page.has_css?(".view-reminder-link")
      click_link "I need to reach"
      assert page.has_css?("#reminder-show-page")
    end
  end
end
