require "test_helper"

class NonUserNavbarTest < Capybara::Rails::TestCase

  test "non-user navbar" do
  	visit '/'
  	assert page.has_content?("Log In")
  	assert page.has_css?("#navbar-logo")
  	refute page.has_content?("Log Out")
  end

  test "logged in user navbar" do
    skip
    visit '/'
    click_on("Log In")
    # How to stub a twitter user?
    # this tests assumes we logged in as the Factory user
    # redirected to twitter auth page
    # twitter auth page redirects back to '/' after authorized
    assert page.has_content?("johndoe")
    assert page.has_content?("Log Out")
    refute page.has_content?("Log In")
  end



end
