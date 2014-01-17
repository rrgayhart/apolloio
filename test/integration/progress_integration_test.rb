require "test_helper"

class ProgressFeatureTest < Capybara::Rails::TestCase

  setup do
    Capybara.current_driver = :selenium
    limited_setup
    visit root_path
    click_link 'Log In'
  end

  test 'a goal has progress that is shown' do
    click_link 'Add Goal'
    select('Github', :from => 'api_selection')
    select('4', :from => 'Target Goal')
    select('1', :from => 'Period')
    select('days', :from => 'Period Type')
    VCR.use_cassette('goal_progress1') do
      click_button "Submit Goal"
      assert page.has_css?(".progress-bar")
      within '.sr-only' do
        assert page.has_content?('100% Complete')
      end
    end
  end
end
