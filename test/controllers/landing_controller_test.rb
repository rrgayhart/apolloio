require "test_helper"

class LandingControllerTest < ActionController::TestCase 

  test "access to the root folder" do
  	get :index
  	assert_response :success
    assert_template :index
  end

end
