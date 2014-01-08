require "test_helper"

class NonUserNavbarTest < Capybara::Rails::TestCase 

  test "non-user navbar" do
  	visit '/'
  	assert page.has_content?("Login")
  	assert page.has_css?("#navbar-logo")
  	refute page.has_content?("Log Out")
  end

  # test "logged in user navbar" do
  #   visit '/'
    
  #   assert page.has_content("Log Out")
  # end



end
