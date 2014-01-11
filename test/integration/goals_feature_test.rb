require './test/test_helper'

class GoalsFeatureTest < Capybara::Rails::TestCase

  setup do
    Capybara.current_driver = :selenium
    visit root_path
    @auth = OmniAuth.config.mock_auth[:twitter]
    @user = User.from_omniauth(@auth)
    click_link 'Log In'
  end

  test 'typical_goal_thing' do
    click_link 'Add Goal'
    assert page.has_content?('Create A New Goal')
    select('Github', :from => 'api_selection')
    fill_in 'Name', :with => 'Goal #1'
    fill_in 'Description', :with => 'Goal #1'
    select('1', :from => 'Target Goal')
    select('1', :from => 'Period')
    select('Daily', :from => 'Period Type')
    fill_in "Start Date", :with => "01/09/2014"
    click_button "Submit Goal"
    assert page.has_content?('Goal #1')
  end

end
