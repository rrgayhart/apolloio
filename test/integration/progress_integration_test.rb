require "test_helper"
require 'minitest/metadata'

class ProgressFeatureTest < Capybara::Rails::TestCase
  include MiniTest::Metadata

  setup do
    Capybara.current_driver = :webkit
    limited_setup
    visit root_path
    click_link 'Log In'
  end

  test 'a goal has progress that is shown' do
    Timecop.travel("Sat, 19 Jan 2014".to_date) do
      click_link 'Add Goal'
      select('Github', :from => 'api_selection')
      fill_in 'Target Goal', :with => 1
      select('day', :from => 'Period Type')
      VCR.use_cassette('goal_progress10') do
        click_button "Submit Goal"
        assert page.has_css?(".progress-bar")
        within '.sr-only' do
          assert page.has_content?('0% Complete')
        end
      end
    end
  end
end
