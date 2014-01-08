require "test_helper"

class GoalsControllerTest < ActionController::TestCase
   test "the truth" do
     get :index
     assert_response :success
     assert_template :index
   end
end
