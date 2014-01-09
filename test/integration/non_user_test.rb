require "test_helper"

class NonUserNavbarTest < Capybara::Rails::TestCase

  test "non-user navbar" do
    visit '/'
    assert page.has_content?("Log In"), "Page is missing 'Log In' button"
    assert page.has_css?("#navbar-logo"), "Page is missing '#navbar-logo' element"
    refute page.has_content?("Log Out"), "Page is not supposed to display 'Log Out'"
  end

end
