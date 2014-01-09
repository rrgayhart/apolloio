require "test_helper"

class GoalsControllerTest < ActionController::TestCase
   test "the truth" do
     get :index
     assert_response :success
     assert_template :index
     assert_not_nil assigns(:goals)
   end
end
