require "test_helper"
require 'minitest/metadata'

class GoalsFeatureTest < Capybara::Rails::TestCase
  include MiniTest::Metadata

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
      select('day', :from => 'Period Type')
      click_button "Submit Goal"
      refute page.has_content?("Target")
      assert page.has_content?("Add Reminder")
      click_link "Add Reminder"
      assert page.has_css?(".reminder-submit-button")
      fill_in "Target", :with => "2"
      select("Afternoon", :from => "Time Deadline")
      fill_in "Day deadline", :with => "5"
      check "Twitter"
      check "Sms"
      assert page.has_content?("Enter phone number:")
      fill_in "reminder[add_phone_number]", :with => "7174250868"
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

    test 'an exercism goal can be created' do
    Timecop.travel("Sat, 19 Jan 2014".to_date) do
      VCR.use_cassette('goal_progress5') do
        click_link 'Add Goal'
        assert page.has_css?('#create-goal-title')
        select('Exercism', :from => 'api_selection')
        select('1', :from => 'Target Goal')
        select('day', :from => 'Period Type')
        select('ruby', :from => 'Language')
        select('nitpick', :from => 'Type')
        click_button "Submit Goal"
        refute page.has_content?("Target")
        assert page.has_content?('Progress:')
        assert page.has_content?("Time Left to Complete Goal:")
        assert page.has_content?("Number of Nitpicks Left to Complete Goal:")
      end
    end
  end
end
