require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

end
